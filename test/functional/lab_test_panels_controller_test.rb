require 'test_helper'

class LabTestPanelsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => LabTestPanel.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    LabTestPanel.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    LabTestPanel.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lab_test_panel_url(assigns(:lab_test_panel))
  end
  
  def test_edit
    get :edit, :id => LabTestPanel.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    LabTestPanel.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LabTestPanel.first
    assert_template 'edit'
  end
  
  def test_update_valid
    LabTestPanel.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LabTestPanel.first
    assert_redirected_to lab_test_panel_url(assigns(:lab_test_panel))
  end
  
  def test_destroy
    lab_test_panel = LabTestPanel.first
    delete :destroy, :id => lab_test_panel
    assert_redirected_to lab_test_panels_url
    assert !LabTestPanel.exists?(lab_test_panel.id)
  end
end
