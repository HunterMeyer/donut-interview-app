class TaskCompleteMessage
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
            text: "~#{task}~" # Strikethrough the text to indicate completion
          }
        },
        {
          type: 'context',
          elements: [
            {
              type: 'plain_text',
              text: '✔️ Task Completed'
            }
          ]
        }
      ]
    }
  end

  def self.for_author(assignee:, task:)
    {
      blocks: [
        {
          type: 'section',
          block_id: 'task_notice_block',
          text: {
            type: 'plain_text',
            text: "<@#{assignee[:username]}> has completed a task"
          }
        },
        {
          type: 'divider'
        },
        {
          type: 'section',
          block_id: 'task_text_block',
          text: {
            type: 'mrkdwn',
            text: task
          }
        }
      ]
    }
  end
end
