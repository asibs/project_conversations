class Project < ApplicationRecord
  validates_presence_of :name, :description, :due_date

  has_many :project_statuses, -> { order 'created_at DESC' }
  has_many :comments, -> { order 'created_at DESC' }

  # Helper to get the current (most recent) project status
  def project_status
    project_statuses.first
  end

  # Helper to get the current (most recent) status
  def status
    project_status&.status
  end

  # Helper to get the ID of the current (most recent) status
  def status_id
    status&.id
  end
end
