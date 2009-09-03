require 'test_helper'

class DoctorsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Doctor.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Doctor.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Doctor.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to doctor_url(assigns(:doctor))
  end
  
  def test_edit
    get :edit, :id => Doctor.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Doctor.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Doctor.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Doctor.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Doctor.first
    assert_redirected_to doctor_url(assigns(:doctor))
  end
  
  def test_destroy
    doctor = Doctor.first
    delete :destroy, :id => doctor
    assert_redirected_to doctors_url
    assert !Doctor.exists?(doctor.id)
  end
end
