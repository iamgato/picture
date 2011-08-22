require 'test_helper'

class IstocksControllerTest < ActionController::TestCase
  setup do
    @istock = istocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:istocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create istock" do
    assert_difference('Istock.count') do
      post :create, :istock => @istock.attributes
    end

    assert_redirected_to istock_path(assigns(:istock))
  end

  test "should show istock" do
    get :show, :id => @istock.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @istock.to_param
    assert_response :success
  end

  test "should update istock" do
    put :update, :id => @istock.to_param, :istock => @istock.attributes
    assert_redirected_to istock_path(assigns(:istock))
  end

  test "should destroy istock" do
    assert_difference('Istock.count', -1) do
      delete :destroy, :id => @istock.to_param
    end

    assert_redirected_to istocks_path
  end
end
