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
            requires(:deadline, desc: "the time limit in millisecond", type: Integer)
            optional(:detail, desc: "detail of the task", type: String)
        end
        post("/") do
            title = params[:title]
            deadline = Time.at(params[:deadline] / 1000).to_datetime
            detail = params[:detail]
            todo = Todo.create!(title: title, deadline: deadline, detail: detail)
            API::Entities::TodoEntity::Basic.represent(todo)
        end

        # GET /
        desc(
            "retrieve all known todo",
            entity: API::Entities::TodoEntity::Basic,
            http_codes: [ API::Error403, API::Error500 ].map(&:http_codes)
        )
        params do
            optional(:page, type: Integer, default: 1)
            optional(:per_page, type: Integer, default: 10)
            optional(:in_timestamp, type: Integer, default: 0)
        end
        get("/") do
            API::Entities::TodoEntity::Basic.represent(Todo.first(10), root: "todos", in_timestamp: params[:in_timestamp])
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
        patch("/:todo_id/done") do
            todo = Todo.find(params[:todo_id])
            todo.done!
            API::Entities::TodoEntity::Basic.represent(todo)
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
            todo = Todo.find(params[:todo_id])
            todo.destroy
            API::Entities::Basic.represent(success: true, message: "Successfully deleted")
        end

    end
end
