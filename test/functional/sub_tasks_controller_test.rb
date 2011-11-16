require 'test_helper'

class SubTasksControllerTest < ActionController::TestCase
  setup do
    @sub_task = sub_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_task" do
    assert_difference('SubTask.count') do
      post :create, :sub_task => @sub_task.attributes
    end

    assert_redirected_to sub_task_path(assigns(:sub_task))
  end

  test "should show sub_task" do
    get :show, :id => @sub_task.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sub_task.to_param
    assert_response :success
  end

  test "should update sub_task" do
    put :update, :id => @sub_task.to_param, :sub_task => @sub_task.attributes
    assert_redirected_to sub_task_path(assigns(:sub_task))
  end

  test "should destroy sub_task" do
    assert_difference('SubTask.count', -1) do
      delete :destroy, :id => @sub_task.to_param
    end

    assert_redirected_to sub_tasks_path
  end
end
