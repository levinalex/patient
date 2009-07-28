require 'test_helper'

class LabTestLinearRangesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestLinearRange.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestLinearRange.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestLinearRange.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_linear_range_url(assigns(:lab_test_linear_range))
  end
  
  def test_edit
    get :edit, :id => LabTestLinearRange.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestLinearRange.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestLinearRange.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestLinearRange.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestLinearRange.first
    assert_redirected_to lab_test_linear_range_url(assigns(:lab_test_linear_range))
  end
  
  def test_destroy
    lab_test_linear_range = LabTestLinearRange.first
    delete :destroy, :id => lab_test_linear_range
    assert_redirected_to lab_test_linear_ranges_url
    assert !LabTestLinearRange.exists?(lab_test_linear_range.id)
  end
end
