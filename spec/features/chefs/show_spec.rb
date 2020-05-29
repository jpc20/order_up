require 'rails_helper'

RSpec.describe "Chef Show page" do

  before :each do
    @chef = Chef.create(name: "Chef")
    @dish = @chef.dishes.create(name: "Dish", description: "Tasty")
    @dish2 = @chef.dishes.create(name: "Dish", description: "Tasty")
    @ingredient1 = Ingredient.create(name: "Rice", calories: 10)
    @ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
    @ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
    @ingredient4 = Ingredient.create(name: "Cereal", calories: 600)
    @ingredient5 = Ingredient.create(name: "FAKE", calories: 700)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient3.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient4.id)
  end

  it "text" do
    visit "/chefs/#{@chef.id}"
    expect(page).to have_content(@chef.name)
    click_link("Ingredients used by #{@chef.name}")
    expect(current_path).to eq("/chefs/#{@chef.id}/ingredients")
    expect(page).to have_content(@ingredient1.name)
    expect(page).to have_content(@ingredient2.name)
    expect(page).to have_content(@ingredient3.name)
    expect(page).to have_content(@ingredient4.name)
    expect(page).to_not have_content(@ingredient5.name)
  end
end
