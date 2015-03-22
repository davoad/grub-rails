require 'rails_helper'

RSpec.describe PublicationsController, :type => :controller do

  let(:valid_attributes) {
    attributes_for(:publication)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_publication)
  }

  context 'unauthenticated' do
    it 'redirects to sign in page when unauthenticated' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
  end

  context 'authenticated' do
    before(:each) do
      sign_in
    end

    describe 'GET index' do
      it 'assigns all publications as @publications' do
        publication = create(:publication)
        get :index
        expect(assigns(:publications)).to eq([publication])
      end
    end

    describe 'GET show' do
      it 'assigns the requested publication as @publication' do
        publication = create(:publication)
        get :show, id: publication
        expect(assigns(:publication)).to eq(publication)
      end
    end

    describe 'GET new' do
      it 'assigns a new publication as @publication' do
        get :new
        expect(assigns(:publication)).to be_a_new(Publication)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested publication as @publication' do
        publication = create(:publication)
        get :edit, id: publication
        expect(assigns(:publication)).to eq(publication)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Publication' do
          expect {
            post :create, publication: valid_attributes
          }.to change(Publication, :count).by(1)
        end

        it 'creates a new Publication with the valid attributes' do
          post :create, publication: valid_attributes
          new_publication = assigns(:publication).reload
          expect(new_publication.name).to eq valid_attributes[:name]
          expect(new_publication.author).to eq valid_attributes[:author]
          expect(new_publication.edition).to eq valid_attributes[:edition]
        end

        it 'redirects to the created publication' do
          post :create, publication:  valid_attributes
          expect(response).to redirect_to(Publication.last)
        end
      end

      describe 'with invalid params' do
        it 'does not save the publication in the database' do
          expect {
            post :create, publication: invalid_attributes
          }.to_not change(Publication, :count)
        end

        it 'assigns a newly created but unsaved publication as @publication' do
          post :create, publication:  invalid_attributes
          expect(assigns(:publication)).to be_a_new(Publication)
        end

        it 're-renders the new template' do
          post :create, publication:  invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PATCH update' do
      let(:existing_publication) do
        create(:publication, name: 'My pub')
      end

      describe 'with valid params' do
        let(:new_publication_name) { Faker::Lorem.characters(20)}
        let(:new_publication) do
          build(:publication, name: new_publication_name)
        end

        let(:updated_publication_params) do
          attributes_for(:publication, name: 'New Name', author: 'Jimmo', edition: '9786')
        end

        it 'updates the requested publication' do
          patch :update, id: existing_publication, publication: updated_publication_params
          existing_publication.reload
          expect(existing_publication.name).to eq 'New Name'
          expect(existing_publication.author).to eq 'Jimmo'
          expect(existing_publication.edition).to eq '9786'
        end

        it 'assigns the requested publication as @publication' do
          patch :update, id: existing_publication, publication: updated_publication_params
          expect(assigns(:publication)).to eq(existing_publication)
        end

        it 'redirects to the publication' do
          patch :update, id: existing_publication, publication: updated_publication_params
          expect(response).to redirect_to(existing_publication)
        end
      end

      describe 'with invalid params' do
        let(:updated_publication_params) do
          attributes_for(:publication, name: nil)
        end

        it 'does not update the requested publication' do
          patch :update, id: existing_publication, publication: updated_publication_params
          existing_publication.reload
          expect(existing_publication.name).to eq 'My pub'
        end

        it 'assigns the publication as @publication' do
          patch :update, id: existing_publication, publication: updated_publication_params
          expect(assigns(:publication)).to eq(existing_publication)
        end

        it 're-renders the edit template' do
          patch :update, id: existing_publication, publication: updated_publication_params
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested publication' do
        publication = create(:publication)
        expect {
          delete :destroy, id: publication
        }.to change(Publication, :count).by(-1)
      end

      it 'redirects to the publications list' do
        publication = create(:publication)
        delete :destroy, id: publication
        expect(response).to redirect_to(publications_url)
      end
    end
  end
end
