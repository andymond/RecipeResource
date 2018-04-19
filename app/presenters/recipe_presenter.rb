class RecipePresenter

  def initialize(slug)
    @recipe = Recipe.find_by(slug: slug)
  end

  def id
    recipe.id
  end

  def comments
    recipe.comments
  end

  def primary_image
    if recipe.recipe_images.empty?
      "tray.png"
    else
      recipe.recipe_images.first.recipe_image_url(:index).to_s
    end
  end

  def name
    recipe.name
  end

  def station
    recipe.station
  end

  def ingredients
    recipe.ingredients.map { |i| i.name }
  end

  def quantities
    recipe.recipe_ingredients.map { |ri| ri.quantity}
  end

  def units
    recipe.recipe_ingredients.map { |ri| ri.unit}
  end

  def ingredients_with_quantities_and_units
    ingredients.zip(quantities, units)
  end

  def instructions
    recipe.instructions.map { |i| i.step }
  end

  def slug
    recipe.slug
  end

  private
    attr_reader :recipe

end
