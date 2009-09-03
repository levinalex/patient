require 'test_helper'

class InsuranceProvidersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => InsuranceProvider.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    InsuranceProvider.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    InsuranceProvider.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to insurance_provider_url(assigns(:insurance_provider))
  end
  
  def test_edit
    get :edit, :id => InsuranceProvider.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    InsuranceProvider.any_instance.stubs(:valid?).returns(false)
    put :update, :id => InsuranceProvider.first
    assert_template 'edit'
  end
  
  def test_update_valid
    InsuranceProvider.any_instance.stubs(:valid?).returns(true)
    put :update, :id => InsuranceProvider.first
    assert_redirected_to insurance_provider_url(assigns(:insurance_provider))
  end
  
  def test_destroy
    insurance_provider = InsuranceProvider.first
    delete :destroy, :id => insurance_provider
    assert_redirected_to insurance_providers_url
    assert !InsuranceProvider.exists?(insurance_provider.id)
  end
end
