class RecipesController < ApplicationController
    before_action :authenticate_user!

    def index
        @recipes = Recipe.all.where(user_id: current_user.id)
        
        
        if params[:search] != nil
            @search = Recipe.where(user_id: current_user.id).search_name(params[:search]).limit(5)
        else  
            @search = nil 
        end
        
    end

    def add_shared_recipe 
        @original_recipe = Recipe.find(params["shared_recipe_id"])
        @copied_recipe = @original_recipe.dup
        @copied_recipe.user_id = current_user.id 
        @copied_recipe.save 
        redirect_to posts_path
    end

    def share
        @recipe = Recipe.find(params["recipe_id"])
        @post = Post.new()
        @post.recipe_id = @recipe.id
        @post.user_id = current_user.id
        @post.save 
    end 

    def add_recipe_to_list
         
        @list = List.find(params["list_id"].to_i)
        @list.recipes << Recipe.find(params["recipe_id"].to_i)
        @list.save 
        redirect_to edit_list_path(@list)
        
    end

    def new 
        @recipe = Recipe.new
    end

    def show 
        @recipe = Recipe.find(params[:id])
        @ingredient = Ingredient.new
    end

    def update 
        @recipe = Recipe.find(params[:id])
        respond_to do |format|
            if @recipe.update(recipe_params)
                format.html { redirect_to controller: 'recipes', action: 'index'}
            else
                format.html { render :edit }
            end
        end
    end

    def edit 
        @recipe = Recipe.find(params[:id])
        @ingredient = Ingredient.new
    end 

    def create 
        @recipe = Recipe.new(recipe_params)
        @recipe.user_id = current_user.id
        respond_to do |format|
            if @recipe.save
                format.html { redirect_to edit_recipe_path(@recipe)}
            else
                format.html { render :new }
            end
        end
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        redirect_to recipes_path
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :user_id, :text)
    end
end
