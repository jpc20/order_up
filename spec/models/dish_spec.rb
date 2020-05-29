require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through (:dish_ingredients)}
  end
  describe "methods" do
    it "total_calories" do
      chef = Chef.create(name: "Chef")
      dish = chef.dishes.create(name: "Dish", description: "Tasty")
      ingredient1 = Ingredient.create(name: "Rice", calories: 10)
      ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
      ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
      ingredient4 = Ingredient.create(name: "FAKE", calories: 600)
      ingredient5 = Ingredient.create(name: "FAKE", calories: 700)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient3.id)
      expect(dish.total_calories).to eq(410)
    end
  end

end
