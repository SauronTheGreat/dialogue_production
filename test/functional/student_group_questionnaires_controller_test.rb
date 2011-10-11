require 'test_helper'

class StudentGroupQuestionnairesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_group_questionnaires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_group_questionnaire" do
    assert_difference('StudentGroupQuestionnaire.count') do
      post :create, :student_group_questionnaire => { }
    end

    assert_redirected_to student_group_questionnaire_path(assigns(:student_group_questionnaire))
  end

  test "should show student_group_questionnaire" do
    get :show, :id => student_group_questionnaires(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_group_questionnaires(:one).to_param
    assert_response :success
  end

  test "should update student_group_questionnaire" do
    put :update, :id => student_group_questionnaires(:one).to_param, :student_group_questionnaire => { }
    assert_redirected_to student_group_questionnaire_path(assigns(:student_group_questionnaire))
  end

  test "should destroy student_group_questionnaire" do
    assert_difference('StudentGroupQuestionnaire.count', -1) do
      delete :destroy, :id => student_group_questionnaires(:one).to_param
    end

    assert_redirected_to student_group_questionnaires_path
  end
end
