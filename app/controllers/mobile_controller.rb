class MobileController < ApplicationController
  def index
    @jobs = case params[:order]
      @q = @jobs.ransack(params[:q])
      @jobs = @q.result.order("id DESC").recent.paginate(:page => params[:page], :per_page => 6)
  end
  private

  def job_params
    params.require(:job).permit(:title, :description, :pos, :size, :echo, :comp, :form, :edge, :calc, :color, :spec, :elas, :spare, :symp, :sign, :bio, :path, :treat, :aut, :wage_upper_bound, :wage_lower_bound, :price, :image, :opare, :read, :apple, :ori, :seltrdes, :seltrpos, :seltrecho, :seltrcomp, :seltredge, :seltrcalc, :catamenta, :num, :paper, :person, :hct, :contact_email, :is_hidden, :remove_images, :images => [])
  end
end
