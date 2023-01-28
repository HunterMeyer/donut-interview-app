class TaskAssignmentWorkFlow
  def self.call(client:, payload:)
    author    = payload[:user]
    input     = payload.dig(:view, :state, :values)
    task      = input.dig(:task_text_block, :task_text, :value)
    assignees = input.dig(:task_assignees_block, :task_assignees, :selected_users)

    assignees.each do |assignee_id|
      message    = TaskAssignmentMessage.for_assignee(author: author, task: task)
      channel_id = client.conversations_open(users: assignee_id).channel.id

      client.chat_postMessage(channel: channel_id, **message)
    end
  end
end
