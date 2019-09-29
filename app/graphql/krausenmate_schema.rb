class KrausenmateSchema < GraphQL::Schema
  def self.id_from_object(object, type_definition, query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end
  
  def self.object_from_id(id, query_ctx)
    class_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    # Now, based on `type_name` and `item_id`
    # find an object in your application
    # ....
    Object.const_get(class_name).find(item_id)
  end

  mutation(Types::MutationType)
  query(Types::QueryType)
end
