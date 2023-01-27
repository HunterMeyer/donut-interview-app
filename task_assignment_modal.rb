class TaskAssignmentModal
  def self.create(trigger_id)
    {
      trigger_id: trigger_id,
      view: {
        type: 'modal',
        title: {
          type: 'plain_text',
          text: 'Dough (Beta)',
          emoji: true
        },
        submit: {
          type: 'plain_text',
          text: 'Submit',
        },
        close: {
          type: 'plain_text',
          text: 'Cancel',
          emoji: true
        },
        blocks: [
          {
            type: 'input',
            block_id: 'task_description',
            label: {
              type: 'plain_text',
              text: 'Task description'
            },
            element: {
              type: 'plain_text_input',
              action_id: 'task_description',
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
            block_id: 'task_assignees',
            label: {
              type: 'plain_text',
              text: 'Assignees'
            },
            element: {
              type: 'multi_users_select',
              placeholder: {
                type: 'plain_text',
                text: 'Select one or more',
                emoji: true
              },
              action_id: 'task_assignees'
            }
          }
        ]
      }
    }
  end
end
