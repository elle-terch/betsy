class ReviewsController < ApplicationController


  def new
    @review = Review.new
  end

  def create
    # session[:user_id] != @current_user ? can_review = true : can_review = false
    # if can_review
    @review = Review.new(filtered_params)
    @review.save
    flash[:sucess] = "Thank you for your review!"
    redirect_back fallback_location: '/', allow_other_host: false
    # else
    #   flash[:error] = "A problem occurred: Could not post review"
    #   redirect_back fallback_location: '/', allow_other_host: false

  end

  def edit
  end

  def show
    head :not_found unless @review
  end

  def update

    success_save = @review.update(filtered_params)

    if success_save
      flash[:success] = "Review of #{@item.name} successfully reviewed."
      redirect_to shop_path
    else
      flash.now[:error] =  "Error in reviewing product"
      render :edit, status: 400
    end
  end

  private

  def filtered_params
    return params.require(:review).permit(
      :description,
      :rating,
      :item_id,
      :user_id
    )

  end

end
