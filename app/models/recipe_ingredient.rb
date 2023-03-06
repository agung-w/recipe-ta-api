class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :metric,optional: true
  validate :validate_associations


  private

  def validate_associations
    if metric!=nil
      unless metric.present? 
        errors.add(:metric, 'didnt exist') 
      end
    end
  end
end
