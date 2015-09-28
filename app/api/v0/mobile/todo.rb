class API::V0::Mobile::Todo < API::V0::Mobile::Base
    resources("todo") do
        # POST /
        desc(
            "create new todo",
            entity: API::Entities::TodoEntity::Basic,
            http_codes: [ API::Error403, API::Error500 ].map(&:http_codes)
        )
        params do
            requires(:title, desc: "the todo name", type: String)
            requires(:deadline, desc: "the time limit in timestamp", type: Integer)
            optional(:detail, desc: "detail of the task", type: String)
        end
        post("/") do
            binding.pry
        end

        # GET /
        desc(
            "retrieve all known todo",
            entity: API::Entities::TodoEntity::Basic,
            http_codes: [ API::Error403, API::Error500 ].map(&:http_codes)
        )
        get("/") do
            binding.pry
        end

        # PATCH /:todo_id/done
        desc(
            "mark a todo as done",
            entity: API::Entities::TodoEntity::Basic,
            http_codes: [ API::Error403, API::Error500 ].map(&:http_codes)
        )
        params do
            requires(:todo_id, desc: "the todo id", type: Integer)
        end
        put("/:todo_id/done") do
            binding.pry
        end

        # DELETE /:todo_id
        desc(
            "remove a todo",
            entity: API::Entities::Basic,
            http_codes: [API::Error403, API::Error500].map(&:http_codes)
        )
        params do
            requires(:todo_id, desc: "the todo id", type: Integer)
        end
        delete("/:todo_id") do
            binding.pry
        end

    end
end
