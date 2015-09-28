class Todo < ActiveRecord::Base
    attr_accessible(:title, :detail, :deadline)
    # assume is_done attribute isn't accessible.
    # use .done! to mark a task as done.

    def done!
        self.is_done = true
        self.save!
    end

    def time_left
        deadline.to_i - DateTime.now.utc.to_i
    end

    def passed?
        deadline < DateTime.now.utc
    end
end
