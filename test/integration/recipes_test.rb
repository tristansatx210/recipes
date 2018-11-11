require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ramseys", email: "ramsey@email.com")
    @recipe = Recipe.create(name: "Lasagna", description: "Making the best lasagna ever. All the ingredients you would ever need", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Salad", description: "makeing the best chicken salad ever. make in 30 minutes")
    @recipe2.save
  end
  
  test "should get url" do
    get recipes_path
    assert_response :success
  end
  
  test "Should get recipes listings" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "Should get Recipes Show page" do
    get recipes_path(@recipes)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
  
  test "Create new valid recipe" do
    get new_recipe_path
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicken, add vegetables, cook for 20 minutes, serve delicious meal"
    assert_difference 'Recipe.count', 1 do
    post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
  end
  follow_redirect!
  assert_match name_of_recipe.capitalize, response.body
  assert_match description_of_recipe, response.body
  end
  
  test "Reject invalid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference "Recipe.count" do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end
