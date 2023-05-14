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

  def search_by_ingredient(ingredients)
    sql = 
    "
      SELECT DISTINCT recipes.*
      FROM recipes
      JOIN recipe_ingredients ON recipes.id = recipe_ingredients.recipe_id
      JOIN ingredients ON ingredients.id=recipe_ingredients.ingredient_id
      GROUP by recipes.id,recipe_ingredients.recipe_id
    "
    ingredients.split(',').each_with_index { |el, i|
      if i==0
        sql+=" HAVING COUNT(*) FILTER (WHERE ingredients.name LIKE '%#{el.downcase}%') > 0"
      else
        sql+=" AND COUNT(*) FILTER (WHERE ingredients.name LIKE '%#{el.downcase}%') > 0"
      end
    }
    recipe = Recipe.find_by_sql(sql)
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
