module API::Entities::ErrorEntity
    class Presenter < Grape::Entity
        def self._id
        end

        expose(:code, as: :error_code, documentation: {type: "Integer"})
        expose(:message, documentation: {type: "String"})
    end
end

class API::Error403 < StandardError
    def self.http_codes
        [403, "Invalid Request", API::Entities::ErrorEntity::Presenter]
    end
end

class API::Error500 < StandardError
    def self.http_codes
        [500, "Server Error", API::Entities::ErrorEntity::Presenter]
    end
end
