require 'test_helper'

class DeliveryPackagesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get delivery_packages_edit_url
    assert_response :success
  end

  test "should get update" do
    get delivery_packages_update_url
    assert_response :success
  end

end
