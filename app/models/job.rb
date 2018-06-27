class Job < ApplicationRecord
    validates :title, presence: true
    mount_uploader :image, ImageUploader
    mount_uploaders :images, JobImageUploader
       serialize :images, JSON

    has_many :resumes

    def publish!
      self.is_hidden = false
      self.save
    end

    def hide!
      self.is_hidden = true
      self.save
    end

    scope :published, -> { where(is_hidden: false) }
    scope :recent, -> { order('created_at DESC') }
end
