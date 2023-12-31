class ExperiencesController < ApplicationController
  def index
    @saved_experience = SavedExperience.new
    if params[:query].present?
      @experiences = Experience.search_by_address(params[:query])
    else
      @experiences = Experience.all
    end
  end

  def new
    @journey = Journey.find(params[:journey_id])
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    @journey = Journey.find(params[:journey_id])
    @experience.journey = @journey
    if @experience.save!
      redirect_to profile_page_path(current_user.username)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def like
    @experience = Experience.find(params[:id])
    if current_user.voted_for? @experience
      @experience.unliked_by current_user
    else
      @experience.liked_by current_user
    end
    respond_to do |format|
      format.html { redirect_to experiences_path }
      format.text { render partial: "experiences/like_link", locals: { experience: @experience }, formats: [:html] }
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:title, :content, :address, :category, :journey, photos: [])
  end
end
