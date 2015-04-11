require 'rails_helper'

RSpec.describe RatingsController, :type => :controller do

  let(:valid_attributes) {
    attributes_with_foreign_keys(:rating)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_rating)
  }

  context 'unauthenticated' do
    it 'redirects to sign in page when unauthenticated' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
  end

  context 'authenticated' do
    let(:user) { create(:user) }
    before(:each) do
      sign_in(user)
    end

    describe 'POST create' do

      describe 'with valid params' do
        it 'creates a new Recipe' do
          expect {
            post :create, rating: valid_attributes
          }.to change(Rating, :count).by(1)
        end

        it 'creates a new Rating with the valid attributes' do
          post :create, rating: valid_attributes
          new_rating = assigns(:rating).reload
          expect(new_rating.title).to eq valid_attributes['title']
          expect(new_rating.comments).to eq valid_attributes['comments']
          expect(new_rating.value).to eq valid_attributes['value']
          expect(new_rating.recipe_id).to eq valid_attributes['recipe_id']
          expect(new_rating.user_id).to eq user.id
        end

        it 'assigns a newly created rating as @rating' do
          post :create, rating:  valid_attributes
          expect(assigns(:rating)).to be_a(Rating)
          expect(assigns(:rating)).to be_persisted
        end

        it 'redirects to the associated recipe ' do
          post :create, rating:  valid_attributes
          expect(response).to redirect_to(controller: :recipes, action: :show, id: assigns(:rating).recipe_id )
        end
      end

      describe 'with invalid params' do
        it 'does not save the rating in the database' do
          expect {
            post :create, rating: invalid_attributes
          }.to_not change(Rating, :count)
        end

        it 'assigns a newly created but unsaved rating as @rating' do
          post :create, rating:  invalid_attributes
          expect(assigns(:rating)).to be_a_new(Rating)
        end

        it 're-renders the new template' do
          post :create, rating:  invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PATCH update' do
      let(:existing_rating) do
        create(:rating_with_recipe, title: 'My Rating', user_id: user.id)
      end

      let(:updated_rating_params) do
        attributes_with_foreign_keys(:rating, title: 'New Title', value: 5,  comments: 'New Comment')
      end

      describe 'with valid params' do
        it 'updates the requested rating' do
          patch :update, id: existing_rating, rating: updated_rating_params
          existing_rating.reload
          expect(existing_rating.title).to eq 'New Title'
          expect(existing_rating.value).to eq 5
          expect(existing_rating.comments).to eq 'New Comment'
          expect(existing_rating.user_id).to eq user.id
          expect(existing_rating.recipe_id).to_not eq updated_rating_params[:recipe_id]
        end

        it 'assigns the requested rating as @rating' do
          patch :update, id: existing_rating, rating: updated_rating_params
          expect(assigns(:rating)).to eq(existing_rating)
        end

        it 'redirects to the associated recipe' do
          patch :update, id: existing_rating, rating: updated_rating_params
          expect(response).to redirect_to(controller: :recipes, action: :show, id: assigns(:rating).recipe_id )
        end

      end

      describe 'with invalid params' do
        let(:updated_rating_params) do
          attributes_for(:rating_with_recipe, title: nil, user_id: user.id)
        end

        it 'does not update the requested rating when mandatory filed missing' do
          patch :update, id: existing_rating, rating: updated_rating_params
          existing_rating.reload
          expect(existing_rating.title).to eq 'My Rating'
        end

        it 'assigns the rating as @rating' do
          patch :update, id: existing_rating, rating: updated_rating_params
          expect(assigns(:rating)).to eq(existing_rating)
        end

        it 're-renders the edit template' do
          patch :update, id: existing_rating, rating: updated_rating_params
          expect(response).to render_template('edit')
        end
      end

      describe 'authorization failures' do
        let(:existing_rating_different_user) do
          create(:rating_with_recipe_and_user, title: 'My Rating')
        end

        it 'does not update the requested rating when rating belongs to someone else' do
          patch :update, id: existing_rating_different_user, rating: updated_rating_params
          existing_rating.reload
          expect(existing_rating.title).to eq 'My Rating'
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested rating' do
        rating = create(:rating)
        expect {
          delete :destroy, id: rating
        }.to change(Rating, :count).by(-1)
      end

      it 'redirects to the ratings list' do
        rating = create(:rating)
        delete :destroy, id: rating
        expect(response).to redirect_to(ratings_url)
      end
    end
  end
end
