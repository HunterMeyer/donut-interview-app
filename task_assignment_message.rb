class TaskAssignmentMessage
  def self.create(task:, author:)
    "<@#{author[:username]}> has assigned you the following task: #{task}"
  end
end
