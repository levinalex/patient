require 'test_helper'

class LabTestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTest.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_url(assigns(:lab_test))
  end
  
  def test_edit
    get :edit, :id => LabTest.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTest.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTest.first
    assert_redirected_to lab_test_url(assigns(:lab_test))
  end
  
  def test_destroy
    lab_test = LabTest.first
    delete :destroy, :id => lab_test
    assert_redirected_to lab_tests_url
    assert !LabTest.exists?(lab_test.id)
  end
end
