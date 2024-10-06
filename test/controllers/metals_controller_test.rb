require "test_helper"

class MetalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get metals_index_url
    assert_response :success
  end

  test "should get new" do
    get metals_new_url
    assert_response :success
  end

  test "should get create" do
    get metals_create_url
    assert_response :success
  end

  test "should get edit" do
    get metals_edit_url
    assert_response :success
  end

  test "should get update" do
    get metals_update_url
    assert_response :success
  end

  test "should get show" do
    get metals_show_url
    assert_response :success
  end
end
