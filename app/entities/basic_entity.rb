class API::Entities::Basic < Grape::Entity
    def self._id
    end

    expose(:success, documentation: {type: "Boolean", desc: "success or not"})
    expose(:message, documentation: {type: "String", desc: "the success message"})
end
