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

    def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    job = find_by_id(row["id"]) || new
    job.attributes = row.to_hash.slice(*accessible_attributes)
    job.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
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
