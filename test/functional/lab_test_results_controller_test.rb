require 'test_helper'

class LabTestResultsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestResult.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestResult.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestResult.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_result_url(assigns(:lab_test_result))
  end
  
  def test_edit
    get :edit, :id => LabTestResult.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestResult.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestResult.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestResult.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestResult.first
    assert_redirected_to lab_test_result_url(assigns(:lab_test_result))
  end
  
  def test_destroy
    lab_test_result = LabTestResult.first
    delete :destroy, :id => lab_test_result
    assert_redirected_to lab_test_results_url
    assert !LabTestResult.exists?(lab_test_result.id)
  end
end
