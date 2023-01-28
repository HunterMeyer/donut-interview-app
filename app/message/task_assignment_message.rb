class TaskAssignmentMessage
  def self.for_assignee(author:, task:)
    {
      blocks: [
        {
          type: 'section',
          text: {
            type: 'plain_text',
            text: "<@#{author[:username]}> assigned you a task"
          }
        },
        {
          type: 'divider'
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: task
          }
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              style: 'primary',
              text: {
                type: 'plain_text',
                text: 'Task Complete',
              },
            }
          ]
        }
      ],
      metadata: {
        event_type: 'task_completed',
        event_payload: {
          author: author,
          task: task
        }
      }.to_json
    }
  end
end
