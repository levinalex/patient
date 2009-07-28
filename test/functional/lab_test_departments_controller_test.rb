require 'test_helper'

class LabTestDepartmentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestDepartment.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestDepartment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestDepartment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_department_url(assigns(:lab_test_department))
  end
  
  def test_edit
    get :edit, :id => LabTestDepartment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestDepartment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestDepartment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestDepartment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestDepartment.first
    assert_redirected_to lab_test_department_url(assigns(:lab_test_department))
  end
  
  def test_destroy
    lab_test_department = LabTestDepartment.first
    delete :destroy, :id => lab_test_department
    assert_redirected_to lab_test_departments_url
    assert !LabTestDepartment.exists?(lab_test_department.id)
  end
end
