require 'test_helper'

class LabTestValuesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestValue.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestValue.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestValue.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_value_url(assigns(:lab_test_value))
  end
  
  def test_edit
    get :edit, :id => LabTestValue.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestValue.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestValue.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestValue.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestValue.first
    assert_redirected_to lab_test_value_url(assigns(:lab_test_value))
  end
  
  def test_destroy
    lab_test_value = LabTestValue.first
    delete :destroy, :id => lab_test_value
    assert_redirected_to lab_test_values_url
    assert !LabTestValue.exists?(lab_test_value.id)
  end
end
