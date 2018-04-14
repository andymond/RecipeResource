class RecipeUpdater

  def initialize(attrs)
    @name         = attrs[:recipeName].strip
    @station      = attrs[:recipeStation]
    @ingredients  = attrs[:ingredientList].map
    @instructions = attrs[:instructionList].map
    @recipe       = Recipe.find_by("lower(name) = ?", @name.downcase)
  end

  def update_recipe
    update_ingredients
    update_instructions
    recipe
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
