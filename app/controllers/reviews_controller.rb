class ReviewsController < ApplicationController
  before_action :find_review, only: :destroy

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      @new_review = Review.new
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_path(@review.restaurant) }
      format.js # render reviews/destroy.js.erb
    end
  end

  private
  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
