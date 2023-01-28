class TaskCreateWorkflow
  def self.call(client:, payload:)
    modal = TaskCreateModal.create(trigger_id: payload[:trigger_id])
    client.views_open(modal)
  end
end
