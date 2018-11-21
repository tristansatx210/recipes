require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Ramseys", email: "ramsey@email.com",
                        password: "password", password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: " ", email: "ramsey@email.com"  }}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: "Ramsey1 ", email: "ramsey1@email.com"  }}
    assert_redirect_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Ramsey1", @chef.chefname
    assert_match "ramsey1@email.com", @chef.email
    
  end
  
end
