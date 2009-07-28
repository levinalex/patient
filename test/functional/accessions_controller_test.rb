require 'test_helper'

class AccessionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Accession.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Accession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Accession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to accession_url(assigns(:accession))
  end
  
  def test_edit
    get :edit, :id => Accession.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Accession.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Accession.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Accession.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Accession.first
    assert_redirected_to accession_url(assigns(:accession))
  end
  
  def test_destroy
    accession = Accession.first
    delete :destroy, :id => accession
    assert_redirected_to accessions_url
    assert !Accession.exists?(accession.id)
  end
end
