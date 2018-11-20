require 'test_helper'

class ChefShowsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ramseys", email: "ramsey@email.com",
                          password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Lasagna", description: "Making the best lasagna ever. All the ingredients you would ever need", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Salad", description: "makeing the best chicken salad ever. make in 30 minutes")
    @recipe2.save
  end
  
  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end  
  
end
