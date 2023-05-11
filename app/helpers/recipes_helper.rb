module RecipesHelper
  def delete(id, current_user)
    recipe=Recipe.find_by(id:params[:id])
    if recipe==nil
      raise Exceptions::NotFoundError.new("Recipe not found")
    else
      if recipe.user_id==current_user.id
        if recipe.destroy
          true
        else
          raise Exceptions::RecipeError.new("Cant proccess this now")
        end
      else
        raise Exceptions::RecipeError.new("You can't delete this recipe")
      end
    end
  end

  def update(id,params,current_user)
    recipe=Recipe.find_by(id:id)
    if recipe==nil
      raise Exceptions::NotFoundError.new("Recipe not found")
    else
      if recipe.user_id==current_user.id
        recipe.title=params[:title]
        recipe.description=params[:description]
        recipe.serving=params[:serving]
        recipe.poster_pic_url=params[:poster_pic_url]
        recipe.prep_time=params[:prep_time]
        RecipeIngredient.where(recipe_id:recipe.id).delete_all
        recipe.recipe_ingredients.new(params[:recipe_ingredients_attributes])
        CookingStep.where(recipe_id:recipe.id).delete_all
        recipe.cooking_steps.new(params[:cooking_steps_attributes])
        RecipeTag.where(recipe_id:recipe.id).delete_all
        recipe.recipe_tags.new(params[:recipe_tags_attributes])
        recipe.is_published=nil
        recipe.save
        recipe
      else
        raise Exceptions::RecipeError.new("You can't edit this recipe")
      end
    end
  end
end
