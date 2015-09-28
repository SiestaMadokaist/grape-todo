class CreateTodos < ActiveRecord::Migration
    def self.up
        create_table(:todos) do |t|
            t.datetime(:created_at)
            t.datetime(:updated_at)
            t.string(:title)
            t.text(:detail)
            t.datetime(:deadline)
            t.boolean(:is_done, default: false, null: false)
        end
    end

    def self.down
        drop_table(:todos)
    end
end
