class Todo < ActiveRecord::Base
    attr_accessible(:name, :detail, :deadline)
    # assume is_done attribute isn't accessible.
    # use .done! to mark a task as done.

    def done!
        self.is_done = true
        self.save!
    end
end
