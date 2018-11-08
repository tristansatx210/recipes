require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "Dezzi", email: "dezzi@email.com")
    @recipe = @chef.recipes.build(name: "vegatable", description: "great vegitable recipe")
  end
=begin  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
=end  
  test "Name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "Description shouldn't be less than 25 characters" do
    @recipe.description = "a" * 24
    assert_not @recipe.valid?
  end
  
  test "Description shouldn't be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "recipe without chef should be invalid" do
  @recipe.chef_id = nil
  assert_not @recipe.valid?
  end

end