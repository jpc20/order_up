require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end
  describe "methods" do
    it "ingredients" do
      chef = Chef.create(name: "Chef")
      dish = chef.dishes.create(name: "Dish", description: "Tasty")
      dish2 = chef.dishes.create(name: "Dish", description: "Tasty")
      ingredient1 = Ingredient.create(name: "Rice", calories: 10)
      ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
      ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
      ingredient4 = Ingredient.create(name: "Cereal", calories: 600)
      ingredient5 = Ingredient.create(name: "FAKE", calories: 700)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient3.id)

      expect(chef.ingredients).to eq([ingredient1, ingredient2, ingredient3])
    end
    it "most_popluar_ingredients" do
      chef = Chef.create(name: "Chef")
      dish = chef.dishes.create(name: "Dish", description: "Tasty")
      dish2 = chef.dishes.create(name: "Dish", description: "Tasty")
      dish3 = chef.dishes.create(name: "Dish", description: "Tasty")
      dish4 = chef.dishes.create(name: "Dish", description: "Tasty")
      ingredient1 = Ingredient.create(name: "Rice", calories: 10)
      ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
      ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
      ingredient4 = Ingredient.create(name: "Cereal", calories: 600)
      ingredient5 = Ingredient.create(name: "FAKE", calories: 700)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient1.id)
      DishIngredient.create(dish_id: dish2.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish3.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient2.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient3.id)
      DishIngredient.create(dish_id: dish2.id, ingredient_id: ingredient3.id)
      DishIngredient.create(dish_id: dish.id, ingredient_id: ingredient4.id)
      DishIngredient.create(dish_id: dish2.id, ingredient_id: ingredient4.id)
      DishIngredient.create(dish_id: dish3.id, ingredient_id: ingredient4.id)
      DishIngredient.create(dish_id: dish4.id, ingredient_id: ingredient4.id)

      expect(chef.most_popluar_ingredients.first.name).to eq("Cereal")
      expect(chef.most_popluar_ingredients[1].name).to eq("Eggs")
      expect(chef.most_popluar_ingredients.last.name).to eq("Potatoes")
  end
end
end
