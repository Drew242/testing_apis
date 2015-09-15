require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    users = JSON.parse(response.body)
    user  = users.first

    assert_response :success
    assert_equal 2, users.count
    assert "Drew",  user["name"]
  end

  test "#show" do
    get :show, format: :json, id: User.first.id

    user = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Drew",             user[:name]
    assert_equal "drew@gmail.com", user[:email]
  end

  test "#create" do
    user_params = { name: "Mitch", email: "mitch@gmail.com" }
    post :create, format: :json, user: user_params

    user        = User.last
    json_user   = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Mitch",           json_user[:name]
    assert_equal "mitch@gmail.com", json_user[:email]
    assert_equal "Mitch",           user.name
    assert_equal "mitch@gmail.com", user.email
  end

  test "#update" do
    user_params = { name: "Mitch", email: "mitch@gmail.com" }
    old_user    = User.first

    put :update, format: :json, id: User.first.id, user: user_params

    new_user    = User.find(old_user.id)

    assert_response :success
    assert_equal "Mitch",            new_user.name
    assert_equal "mitch@gmail.com",  new_user.email
    refute_equal old_user.name,      new_user.name
    refute_equal old_user.email,     new_user.email
  end

  test "#destroy" do
    assert_difference('User.count', -1) do
      delete :destroy, format: :json, id: User.first.id
    end

    assert_response :success
  end
end
