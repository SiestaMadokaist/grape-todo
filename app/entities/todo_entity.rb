class API::Entities::TodoEntity
    class Basic < Grape::Entity
        # this method helps documenting.
        def self._id
        end

        expose(:title, documentation: {type: "String", desc: "#TODO"})
        expose(:deadline, documentation: {type: "Integer", desc: "timestamp in second"})
        expose(:time_left, documentation: {type: "Integer", desc: "in second"})
        expose(:is_done, documentation: {type: "Boolean", desc: "#TODO"})
    end
end
