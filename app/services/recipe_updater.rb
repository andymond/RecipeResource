class RecipeUpdater

  def initialize(attrs, slug)
    @name         = attrs[:recipeName].strip
    @station      = attrs[:recipeStation].strip
    @ingredients  = attrs[:ingredientList].map
    @instructions = attrs[:instructionList].map
    @recipe       = Recipe.find_by(slug: slug)
  end

  def update_recipe
    update_name_and_station
    update_ingredients
    update_instructions
    recipe
  end

  def update_name_and_station
    recipe.update_attributes(name: name, station: station)
  end

  def update_ingredients
    recipe.ingredients.destroy_all
    ingredients.each do |data|
      ingredient = Ingredient.find_or_create_by(name: data["ingredient"])
      RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: ingredient.id, quantity: data["qty"], unit: data["unit"] )
    end
  end

  def update_instructions
    recipe.instructions.destroy_all
    instructions.each do |instruction|
      recipe.instructions.create(step: instruction)
    end
  end

  private

    attr_reader :name,
                :station,
                :ingredients,
                :instructions,
                :recipe
end
