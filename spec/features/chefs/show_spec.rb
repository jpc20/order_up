require 'rails_helper'

RSpec.describe "Chef Show page" do

  before :each do
    @chef = Chef.create(name: "Chef")
    @dish = @chef.dishes.create(name: "Dish", description: "Tasty")
    @dish2 = @chef.dishes.create(name: "Dish2", description: "Tasty")
    @dish3 = @chef.dishes.create(name: "Dish3", description: "Tasty")
    @dish4 = @chef.dishes.create(name: "Dish4", description: "Tasty")
    @dish5 = @chef.dishes.create(name: "Dish5", description: "Tasty")
    @dish6 = @chef.dishes.create(name: "Dish6", description: "Tasty")
    @ingredient1 = Ingredient.create(name: "Rice", calories: 10)
    @ingredient2 = Ingredient.create(name: "Eggs", calories: 100)
    @ingredient3 = Ingredient.create(name: "Potatoes", calories: 300)
    @ingredient4 = Ingredient.create(name: "Cereal", calories: 600)
    @ingredient5 = Ingredient.create(name: "Milk", calories: 80)
    @ingredient6 = Ingredient.create(name: "Raisins", calories: 7)
    @ingredient7 = Ingredient.create(name: "Butter", calories: 300)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient3.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish3.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish4.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish5.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish6.id, ingredient_id: @ingredient4.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish3.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish4.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish5.id, ingredient_id: @ingredient2.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish3.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish4.id, ingredient_id: @ingredient1.id)
    DishIngredient.create(dish_id: @dish2.id, ingredient_id: @ingredient3.id)
    DishIngredient.create(dish_id: @dish3.id, ingredient_id: @ingredient3.id)
    DishIngredient.create(dish_id: @dish.id, ingredient_id: @ingredient5.id)
  end

  it "visitor can go to chefs ingredient index from the show page" do
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

  it "shows the 3 most popular ingredients" do
    visit "/chefs/#{@chef.id}"
    within ".most-popular-ingredients" do
      expect("#{@ingredient4.name}").to appear_before("#{@ingredient2.name}")
      expect("#{@ingredient2.name}").to appear_before("#{@ingredient1.name}")
      expect("#{@ingredient1.name}").to appear_before("#{@ingredient3.name}")
      expect("#{@ingredient3.name}").to appear_before("#{@ingredient5.name}")
      expect(page).to_not have_content(@ingredient6.name)
      expect(page).to_not have_content(@ingredient7.name)
    end
  end
end
