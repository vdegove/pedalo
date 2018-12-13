require 'test_helper'

class PackagePackagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get package_packages_index_url
    assert_response :success
  end

end
