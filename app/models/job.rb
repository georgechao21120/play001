class Job < ApplicationRecord
    validates :title, presence: true
    before_validation :generate_friendly_id, :on => :create
    mount_uploader :image, ImageUploader
    mount_uploaders :images, JobImageUploader
       serialize :images, JSON

    has_many :resumes
    def to_param
      self.friendly_id
    end


  protected
    def generate_friendly_id
     self.friendly_id ||= SecureRandom.uuid
    end

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
