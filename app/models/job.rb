class Job < ApplicationRecord

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

    SELTRPOS = ["甲状腺", ""]
        validates_inclusion_of :seltrpos, :in => SELTRPOS
        SELTRCOMP = ["囊性或几乎完全囊性", "海绵样", "囊实混合性", "实性或几乎完全实性", ""]
        validates_inclusion_of :seltrcomp, :in => SELTRCOMP
        SELTRECHO = ["无回声", "高回声或等回声", "低回声", "极低回声", ""]
        validates_inclusion_of :seltrecho, :in => SELTRECHO
        APPLE = ["横径大于纵径", "纵径大于横径", " "]
        validates_inclusion_of :apple, :in => APPLE
        SELTREDGE = ["光滑", "模糊", "分叶或不规则", "向甲状腺外延伸", ""]
        validates_inclusion_of :seltredge, :in => SELTREDGE
        SELTRCALC = ["无强回声或大彗尾", "粗钙化", "周围型钙化", "点状强回声", ""]
        validates_inclusion_of :seltrcalc, :in => SELTRCALC


end
