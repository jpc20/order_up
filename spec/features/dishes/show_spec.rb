require 'rails_helper'

RSpec.describe "Dish Show page" do

  before :each do
    @chef = Chef.create(name: "Chef")
    @dish = @chef.dishes.create(name: "Dish", description: "Tasty")
    @ingredient1 = Ingredient.create(name: "Rice", calories: 10)
    @ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
    @ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
    @ingredient4 = Ingredient.create(name: "FAKE", calories: 600)
    @ingredient5 = Ingredient.create(name: "FAKE", calories: 700)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient3.id)
  end

  it "visitor can see the ingredients and chefs name" do
    visit "/dishes/#{@dish.id}"
    within ".ingredients" do
      expect(page).to have_content(@ingredient1.name)
      expect(page).to have_content(@ingredient2.name)
      expect(page).to have_content(@ingredient3.name)
    end
    expect(page).to have_content(@chef.name)
  end

  it "visitor can see the total calories for that dish" do
    visit "/dishes/#{@dish.id}"
    expect(page).to have_content("Total Calories: 410")
  end
end
