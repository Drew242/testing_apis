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

  test "#show" do
    get :show, format: :json, id: Item.first.id

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Lanister",           item[:name]
    assert_equal "My uncle is my dad", item[:description]
  end

  test "#create" do
    item_params = { name: "Arya", description: "Is not blind" }

    post :create, format: :json, item: item_params

    assert_response :success
  end
end
