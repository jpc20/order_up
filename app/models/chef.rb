class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredients
    Ingredient.joins(:dishes)
              .where("dishes.chef_id = ?", id)
              .distinct
  end

  def most_popluar_ingredients
    Ingredient.joins(:dishes)
              .where("dishes.chef_id = ?", id)
              .select("count(ingredients.id) AS times_used", "name")
              .group("ingredients.id")
              .order("times_used desc")
              .limit(3)
  end

end
