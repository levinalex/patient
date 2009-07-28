require 'test_helper'

class LabTestAbsurdRangesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestAbsurdRange.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestAbsurdRange.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestAbsurdRange.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_absurd_range_url(assigns(:lab_test_absurd_range))
  end
  
  def test_edit
    get :edit, :id => LabTestAbsurdRange.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestAbsurdRange.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestAbsurdRange.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestAbsurdRange.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestAbsurdRange.first
    assert_redirected_to lab_test_absurd_range_url(assigns(:lab_test_absurd_range))
  end
  
  def test_destroy
    lab_test_absurd_range = LabTestAbsurdRange.first
    delete :destroy, :id => lab_test_absurd_range
    assert_redirected_to lab_test_absurd_ranges_url
    assert !LabTestAbsurdRange.exists?(lab_test_absurd_range.id)
  end
end
