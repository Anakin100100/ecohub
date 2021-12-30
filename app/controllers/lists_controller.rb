class ListsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    
    def index
        @lists = List.all.where(user_id: current_user.id)
    end 

    def new 
        @list = List.new 
        @list.user_id = current_user.id 
    end 

    def show
        @list = List.find(params[:id]) 
        @recipes = @list.recipes
    end 

    def edit 
        @list = List.find(params[:id]) 
        @recipes = @list.recipes
        @ingredient = Ingredient.new
    end 

    def update 
        if params[:search] == nil
            @list = List.find(params[:id])
            if params[:list] != nil 
                @ingredient = Ingredient.new(ingredient_params)
                @ingredient.is_trash = false
                respond_to do |format|
                    if @ingredient.save
                        @list.ingredients << @ingredient 
                        @list.save 
                        format.html { redirect_to edit_list_path(@list)}
                    end
                end
            else
                respond_to do |format|
                    if @list.update(list_params)
                        format.html { redirect_to controller: 'lists', action: 'index'}
                    else
                        format.html { render :edit }
                    end
                end
            end 
        else  
            @search = Recipe.where(user_id: current_user.id).search_name(params[:search]).limit(5)
            redirect_to edit_list_path(List.find(params[:list][:id].to_i), search: @search.as_json, search_phrase: params[:search])
        end
    end 

    def create 
        @list = List.new(list_params)
        @list.user_id = current_user.id
        respond_to do |format|
            if @list.save
              format.html { redirect_to edit_list_path(@list)}
            else
              format.html { render :new }
            end
        end
    end 

    def destroy
        @list = List.find(params[:id]) 
        @list.destroy
        redirect_to lists_path
    end

    private 

    def list_params
        params.require(:list).permit(:name, :user_id)
    end

    def ingredient_params
        if params[:ingredient] != nil
            params.require(:ingredient).permit(:name, :user_id, :weight, :price, :is_trash)
        end
    end
end
