require 'test_helper'

class MentorsControllerTest < ActionController::TestCase
  setup do
    @mentor = mentors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mentors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mentor" do
    assert_difference('Mentor.count') do
      post :create, mentor: { access_token: @mentor.access_token, birthday: @mentor.birthday, email: @mentor.email, first_name: @mentor.first_name, last_name: @mentor.last_name, picture_url: @mentor.picture_url }
    end

    assert_redirected_to mentor_path(assigns(:mentor))
  end

  test "should show mentor" do
    get :show, id: @mentor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mentor
    assert_response :success
  end

  test "should update mentor" do
    put :update, id: @mentor, mentor: { access_token: @mentor.access_token, birthday: @mentor.birthday, email: @mentor.email, first_name: @mentor.first_name, last_name: @mentor.last_name, picture_url: @mentor.picture_url }
    assert_redirected_to mentor_path(assigns(:mentor))
  end

  test "should destroy mentor" do
    assert_difference('Mentor.count', -1) do
      delete :destroy, id: @mentor
    end

    assert_redirected_to mentors_path
  end
end
