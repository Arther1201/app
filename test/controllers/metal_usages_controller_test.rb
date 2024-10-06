require "test_helper"

class MetalUsagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get metal_usages_new_url
    assert_response :success
  end

  test "should get create" do
    get metal_usages_create_url
    assert_response :success
  end
end
