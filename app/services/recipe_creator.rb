class RecipeCreator

  def initialize(restaurant, attrs)
    @recipe       = restaurant.recipes.create(name: attrs[:name], station: attrs[:station])
    @ingredients  = attrs[:ingredients] || {}
    @qty          = attrs[:qty] || {}
    @unit         = attrs[:unit] || {}
    @instructions = attrs[:instructions] || {}
  end

  def create_recipe
    add_ingredients
    add_instructions
    recipe
  end

  def ingredients_by_row
    ingredients_and_qty = ingredients.merge(qty) { |num, name, qty| [name, qty]}
    ingredients_and_qty.merge(unit) { |num, n_a_q, unit| n_a_q << unit }
  end

  def add_ingredients
    ingredients_by_row.each do |num, data|
      ingredient = Ingredient.find_or_create_by(name: data[0])
      RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: ingredient.id, quantity: data[1], unit: data[2])
    end
  end

  def add_instructions
    instructions.each { |num, i| recipe.instructions.create(step: i)}
  end

  private
    attr_reader :recipe, :ingredients, :qty, :unit, :instructions

end
