class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
            @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC')
            else
              Job.published.recent
            end

            @q = @jobs.ransack(params[:q])
            @jobs = @q.result.order("id DESC").recent.paginate(:page => params[:page], :per_page => 6)

  end


  def show
    @job = Job.find_by_friendly_id!(params[:id])
    if @job.is_hidden
        flash[:warning] = "This Job already archived"
        redirect_to root_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
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
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find_by_friendly_id!(params[:id])

    @job.destroy

    redirect_to jobs_path
  end




  private

  def job_params
    params.require(:job).permit(:title, :description, :pos, :size, :echo, :comp, :form, :edge, :calc, :color, :spec, :elas, :spare, :symp, :sign, :bio, :path, :treat, :aut, :wage_upper_bound, :wage_lower_bound, :price, :image, :opare, :read, :apple, :ori, :seltrdes, :seltrpos, :seltrecho, :seltrcomp, :seltredge, :seltrcalc, :catamenta, :num, :paper, :person, :hct, :contact_email, :is_hidden, :remove_images, :images => [])
  end

end
