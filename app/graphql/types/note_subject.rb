module Types
  class NoteSubject < Types::BaseUnion
    description "Objects that can have notes"
    possible_types Types::RecipeType, Types::IngredientType

    def self.resolve_type(object, context)
      byebug
      if object.is_a?(Recipe)
        Types::RecipeType
      else
        Types::IngredientType
      end
    end
  end
end
