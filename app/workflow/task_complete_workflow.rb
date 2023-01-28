class TaskCompleteWorkflow
  def self.call(client:, payload:)
    assignee   = payload[:user]
    task       = payload.dig(:message, :metadata, :event_payload, :task)
    author     = payload.dig(:message, :metadata, :event_payload, :author)
    channel_id = payload.dig(:container, :channel_id)
    message_ts = payload.dig(:container, :message_ts)

    # Reqrite task assignment message in assignee DM
    assignee_message = TaskCompleteMessage.for_assignee(author: author, task: task)
    client.chat_update(channel: channel_id, ts: message_ts, **assignee_message)

    # Update author on task completion in author DM
    author_message    = TaskCompleteMessage.for_author(assignee: assignee, task: task)
    author_channel_id = client.conversations_open(users: author[:id]).channel.id
    client.chat_postMessage(channel: author_channel_id, **author_message)
  end
end
