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
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end
