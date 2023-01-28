class TaskCreateModal
  def self.create(trigger_id:)
    {
      trigger_id: trigger_id,
      view: {
        type: 'modal',
        title: {
          type: 'plain_text',
          text: 'Dough Tasks',
          emoji: true
        },
        submit: {
          type: 'plain_text',
          text: 'Submit',
        },
        close: {
          type: 'plain_text',
          text: 'Cancel'
        },
        blocks: [
          {
            type: 'input',
            block_id: 'task_text_block',
            label: {
              type: 'plain_text',
              text: 'Task description'
            },
            element: {
              type: 'plain_text_input',
              action_id: 'task_text',
              min_length: 1,
              focus_on_load: true,
              placeholder: {
                type: 'plain_text',
                text: 'Get me some donuts'
              }
            }
          },
          {
            type: 'input',
            block_id: 'task_assignees_block',
            label: {
              type: 'plain_text',
              text: 'Assignees'
            },
            element: {
              type: 'multi_users_select',
              placeholder: {
                type: 'plain_text',
                text: 'Select one or more',
              },
              action_id: 'task_assignees'
            }
          }
        ]
      }
    }
  end
end
