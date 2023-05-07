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
end
