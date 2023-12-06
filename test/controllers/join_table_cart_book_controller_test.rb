require "test_helper"

class JoinTableCartBookControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get join_table_cart_book_create_url
    assert_response :success
  end

  test "should get update" do
    get join_table_cart_book_update_url
    assert_response :success
  end

  test "should get destroy" do
    get join_table_cart_book_destroy_url
    assert_response :success
  end
end
