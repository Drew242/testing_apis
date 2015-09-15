require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    items = JSON.parse(response.body)
    item  = items.first

    assert_response :success
    assert_equal 2, items.count
    assert "Jon Snow", item["name"]
  end
end