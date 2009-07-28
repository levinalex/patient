require 'test_helper'

class LabTestValueOptionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestValueOption.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestValueOption.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestValueOption.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_value_option_url(assigns(:lab_test_value_option))
  end
  
  def test_edit
    get :edit, :id => LabTestValueOption.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestValueOption.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestValueOption.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestValueOption.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestValueOption.first
    assert_redirected_to lab_test_value_option_url(assigns(:lab_test_value_option))
  end
  
  def test_destroy
    lab_test_value_option = LabTestValueOption.first
    delete :destroy, :id => lab_test_value_option
    assert_redirected_to lab_test_value_options_url
    assert !LabTestValueOption.exists?(lab_test_value_option.id)
  end
end
