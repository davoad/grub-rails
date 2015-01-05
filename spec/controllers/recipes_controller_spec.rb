require 'rails_helper'

RSpec.describe RecipesController, :type => :controller do

  let(:valid_attributes) {
    attributes_for(:recipe)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_recipe)
  }

  describe 'GET index' do
    it 'assigns all recipes as @recipes' do
      recipe = create(:recipe)
      get :index
      expect(assigns(:recipes)).to eq([recipe])
    end
  end

  describe 'GET show' do
    it 'assigns the requested recipe as @recipe' do
      recipe = create(:recipe)
      get :show, id: recipe
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe 'GET new' do
    it 'assigns a new recipe as @recipe' do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested recipe as @recipe' do
      recipe = create(:recipe)
      get :edit, id: recipe
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Recipe' do
        expect {
          post :create, recipe: valid_attributes
        }.to change(Recipe, :count).by(1)
      end

      it 'creates a new Recipe with the valid attributes' do
          post :create, recipe: valid_attributes
          new_recipe = assigns(:recipe).reload
          expect(new_recipe.name).to eq valid_attributes[:name]
          expect(new_recipe.page_number).to eq valid_attributes[:page_number]
          expect(new_recipe.tags).to eq valid_attributes[:tag_list].delete(' ').split(',')
      end

      it 'creates a new Recipe and a new Publication' do
        attributes = valid_attributes.merge(publication_attributes: build(:publication).attributes)
        the_post = -> { post :create, recipe: attributes }
        expect(the_post).to change(Publication, :count).by(1)
        expect(the_post).to change(Recipe, :count).by(1)
      end

      it 'creates a new Recipe with an existing Publication' do
        publication = create(:publication)
        attributes = valid_attributes.merge(publication_id: publication.id)
        the_post = -> { post :create, recipe: attributes }
        expect(the_post).to change(Publication, :count).by(0)
        expect(the_post).to change(Recipe, :count).by(1)
        new_recipe = assigns(:recipe).reload
        expect(new_recipe.publication_id).to eq publication.id
      end

      it 'assigns a newly created recipe as @recipe' do
        post :create, recipe:  valid_attributes
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it 'redirects to the created recipe' do
        post :create, recipe:  valid_attributes
        expect(response).to redirect_to(Recipe.last)
      end
    end

    describe 'with invalid params' do
      it 'does not save the recipe in the database' do
        expect {
          post :create, recipe: invalid_attributes
        }.to_not change(Recipe, :count)
      end

      it 'assigns a newly created but unsaved recipe as @recipe' do
        post :create, recipe:  invalid_attributes
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end

      it 're-renders the new template' do
        post :create, recipe:  invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH update' do
    let(:existing_recipe) do
      create(:recipe, name: 'My Recipe')
    end

    describe 'with valid params' do
      let(:publication) do
        create(:publication)
      end

      let(:updated_recipe_params) do
        attributes_for(:recipe, name: 'New Name', page_number: 345, tag_list: 'yy, zz')
      end

      it 'updates the requested recipe' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        existing_recipe.reload
        expect(existing_recipe.name).to eq 'New Name'
        expect(existing_recipe.page_number).to eq 345
        expect(existing_recipe.tags).to eq ['yy', 'zz']
      end

      it 'updates the recipe with a new publication' do
        updated_recipe_params.merge!(publication_id: publication.id)
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        existing_recipe.reload
        expect(existing_recipe.publication_id).to eq publication.id
      end

      it 'assigns the requested recipe as @recipe' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        expect(assigns(:recipe)).to eq(existing_recipe)
      end

      it 'redirects to the recipe' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        expect(response).to redirect_to(existing_recipe)
      end
    end

    describe 'with invalid params' do
      let(:updated_recipe_params) do
        attributes_for(:recipe, name: nil)
      end

      it 'does not update the requested recipe' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        existing_recipe.reload
        expect(existing_recipe.name).to eq 'My Recipe'
      end

      it 'assigns the recipe as @recipe' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        expect(assigns(:recipe)).to eq(existing_recipe)
      end

      it 're-renders the edit template' do
        patch :update, id: existing_recipe, recipe: updated_recipe_params
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested recipe' do
      recipe = create(:recipe)
      expect {
        delete :destroy, id: recipe
      }.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe = create(:recipe)
      delete :destroy, id: recipe
      expect(response).to redirect_to(recipes_url)
    end
  end

end
