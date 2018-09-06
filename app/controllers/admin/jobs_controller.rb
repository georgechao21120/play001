require 'csv'
require 'utf8-cleaner'

class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin
  layout "admin"

  def show
    @job = Job.find_by_friendly_id!(params[:id])
  end

  def index
    @jobs = Job.all
      respond_to do |format|
              format.html
              format.xlsx
              format.csv {
                @jobs = @jobs.reorder("id ASC")
                csv_string = CSV.generate do |csv|
                  csv << ["名称", "模板", "正常值", "部位", "切面", "大小", "回声", "成分", "形态", "边缘", "钙化", "血流", "频谱", "弹性（质地）", "症状", "体征", "生化", "病理", "病因", "治疗", "造影", "整理者&联系方式", "参考文献"]
                  @jobs.each do |r|
                    csv << [r.title, r.description,r.num, r.pos, r.aut, r.size, r.echo, r.comp, r.form, r.edge, r.calc, r.color, r.spec, r.elas, r.symp, r.sign, r.bio, r.path, r.hct, r.treat, r.spare, r.person, r.paper]
                  end
                end
                send_data csv_string, :filename => "#{@job}-jobs-#{Time.now.to_s(:number)}.csv"
              }
            end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find_by_friendly_id!(params[:id])
  end

  def update
    @job = Job.find_by_friendly_id!(params[:id])
    if @job.update(job_params)
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find_by_friendly_id!(params[:id])

    @job.destroy

    redirect_to admin_jobs_path
  end


    def publish
      @job = Job.find_by_friendly_id!(params[:id])
      @job.is_hidden = false
      @job.save
      redirect_to :back

    end

    def hide
      @job = Job.find_by_friendly_id!(params[:id])
      @job.is_hidden = true
      @job.save
      redirect_to :back

    end


      def import
    csv_string = params[:csv_file].read.force_encoding('utf-8')

    jobs = @job.jobs

    success = 0
    failed_records = []

    CSV.parse(csv_string) do |row|
      job = @job.jobs.new(   :title => row[0] ,
                                   :num => row[1],
                                   :description => row[2],
                                   :pos => row[3],
                                   :aut => row[4],
                                   :size => row[5])

      if job.save
        success += 1
      else
        failed_records << [row, job]
        Rails.logger.info("#{row} ----> #{job.errors.full_messages}")
      end
    end

    flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
    redirect_to admin_jobs_path(@job)
  end



  private

  def job_params
    params.require(:job).permit(:title, :description, :pos, :size, :echo, :comp, :form, :edge, :calc, :color, :spec, :elas, :spare, :symp, :sign, :bio, :path, :treat, :aut, :wage_upper_bound, :wage_lower_bound, :price, :image, :opare, :read, :apple, :ori, :seltrdes, :seltrpos, :seltrecho, :seltrcomp, :seltredge, :seltrcalc, :catamenta, :num, :paper, :person, :hct, :contact_email, :is_hidden, :remove_images, :images => [])
  end

end
