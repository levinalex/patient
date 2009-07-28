require 'test_helper'

class LabTestCriticalRangesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestCriticalRange.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestCriticalRange.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestCriticalRange.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_critical_range_url(assigns(:lab_test_critical_range))
  end
  
  def test_edit
    get :edit, :id => LabTestCriticalRange.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestCriticalRange.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestCriticalRange.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestCriticalRange.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestCriticalRange.first
    assert_redirected_to lab_test_critical_range_url(assigns(:lab_test_critical_range))
  end
  
  def test_destroy
    lab_test_critical_range = LabTestCriticalRange.first
    delete :destroy, :id => lab_test_critical_range
    assert_redirected_to lab_test_critical_ranges_url
    assert !LabTestCriticalRange.exists?(lab_test_critical_range.id)
  end
end
