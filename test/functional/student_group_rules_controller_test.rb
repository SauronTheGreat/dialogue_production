require 'test_helper'

class StudentGroupRulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_group_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_group_rule" do
    assert_difference('StudentGroupRule.count') do
      post :create, :student_group_rule => { }
    end

    assert_redirected_to student_group_rule_path(assigns(:student_group_rule))
  end

  test "should show student_group_rule" do
    get :show, :id => student_group_rules(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_group_rules(:one).to_param
    assert_response :success
  end

  test "should update student_group_rule" do
    put :update, :id => student_group_rules(:one).to_param, :student_group_rule => { }
    assert_redirected_to student_group_rule_path(assigns(:student_group_rule))
  end

  test "should destroy student_group_rule" do
    assert_difference('StudentGroupRule.count', -1) do
      delete :destroy, :id => student_group_rules(:one).to_param
    end

    assert_redirected_to student_group_rules_path
  end
end
