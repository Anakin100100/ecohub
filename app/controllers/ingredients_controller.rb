class IngredientsController < ApplicationController
    before_action :authenticate_user!
    
    def create 
        @ingredient = Ingredient.new(ingredient_params)
        @ingredient.user_id = current_user.id 

        if params[:recipe] != nil 
            @ingredient.is_trash = false
            respond_to do |format|
                if @ingredient.save
                    @recipe = Recipe.find(params[:recipe][:id].to_i)
                    @recipe.ingredients << @ingredient 
                    @recipe.save 
                end
                format.html { redirect_to edit_recipe_path(@recipe)}
            end
        elsif params[:list] != nil 
            @ingredient.is_trash = false
            respond_to do |format|
                if @ingredient.save
                    @list = List.find(params[:list][:id].to_i)
                    @list.ingredients << @ingredient 
                    @list.save 
                end
                format.html { redirect_to edit_list_path(@list)}
            end
        else
            respond_to do |format|
                @ingredient.is_trash = true
                @ingredient.save
                format.html { redirect_to controller: :ingredients, action: :wasted_ingredients }
            end  
        end
    end

    def new 
        @ingredient = Ingredient.new 
    end

    def wasted_ingredients
        if params["offset"] 
            @offset = params["offset"].to_i
        else  
            @offset = Time.now.month
        end 
        
        if @offset > 12 || @offset <= 0
            year =  Time.now.year + ((@offset - @offset%12)/12).to_i
            month = ((@offset%12).to_i).abs + 1
        else
            year  = Time.now.year  
            month = @offset
        end 

        @month_and_year = Date.new(year,month,1).strftime("%B %Y")
        @wasted_ingredients = Ingredient.where(created_at: Date.new(year,month,1)..Date.new(year,month,-1)).where(is_trash: true)
    end

    def destroy
        @ingredient = Ingredient.find(params[:ingredient].to_i)
        @ingredient.destroy
        origin = params[:origin] 
        if origin == "recipe"
            redirect_to edit_recipe_path(Recipe.find(params[:id].to_i))
        end
        if origin == "list"
            redirect_to edit_list_path(List.find(params[:id].to_i))
        end 
        # usuwanie zmarnowanej żywności nie jest zaimplementowane. 
    end 

    def edit
        @ingredient = Ingredient.find(params[:ingredient]) 
        @options = {}
        @options[:origin] = params[:origin] 
        @options[:origin_id] = params[:id]
    end 

    def update
        @ingredient = Ingredient.find(params[:id])
        respond_to do |format|
            if @ingredient.update(ingredient_params)
                if params[:origin][:name] == "recipe"
                    format.html { redirect_to edit_recipe_path(Recipe.find(params[:origin][:id].to_i)) }
                elsif params[:origin][:name] == "list"
                    format.html { redirect_to edit_list_path(List.find(params[:origin][:id].to_i)) }
                end 
            else  
                format.html { redirect_to recipes_path }
            end
        end
    end 

    private

    def ingredient_params
        params.require(:ingredient).permit(:name, :user_id, :weight, :price, :is_trash)
    end
end
