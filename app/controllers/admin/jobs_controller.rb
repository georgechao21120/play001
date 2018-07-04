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
      @job = Job.find(params[:id])
      @job.publish!

      redirect_to :back
    end

    def hide
      @job = Job.find(params[:id])

      @job.hide!

      redirect_to :back
    end







  private

  def job_params
    params.require(:job).permit(:title, :description, :pos, :size, :echo, :comp, :form, :edge, :calc, :color, :spec, :elas, :spare, :symp, :sign, :bio, :path, :treat, :aut, :wage_upper_bound, :wage_lower_bound, :price, :image, :num, :paper, :person, :hct, :contact_email, :is_hidden, :remove_images, :images => [])
  end
end
