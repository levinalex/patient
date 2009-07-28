require 'test_helper'

class LabTestUnitsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestUnit.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestUnit.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestUnit.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_unit_url(assigns(:lab_test_unit))
  end
  
  def test_edit
    get :edit, :id => LabTestUnit.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestUnit.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestUnit.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestUnit.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestUnit.first
    assert_redirected_to lab_test_unit_url(assigns(:lab_test_unit))
  end
  
  def test_destroy
    lab_test_unit = LabTestUnit.first
    delete :destroy, :id => lab_test_unit
    assert_redirected_to lab_test_units_url
    assert !LabTestUnit.exists?(lab_test_unit.id)
  end
end
