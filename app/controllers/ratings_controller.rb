class RatingsController < ApplicationController
  def index
    # Luetaan cachesta jos löytyy sieltä; kirjoitetaan cacheen jos ei, esim 10min expirauksen johdosta.

    # @rating = Rating.all
    Rails.cache.write("rating all", Rating.all, expires_in: 10.minute) if cache_does_not_contain_data_or_it_is_too_old("rating all")
    @rating = Rails.cache.read "rating all"

    # @top_breweries = Brewery.top 3
    Rails.cache.write("brewery top 3", Brewery.top(3), expires_in: 10.minute) if cache_does_not_contain_data_or_it_is_too_old("brewery top 3")
    @top_breweries = Rails.cache.read "brewery top 3"

    # @top_beers = Beer.top 3
    Rails.cache.write("beer top 3", Beer.top(3), expires_in: 10.minute) if cache_does_not_contain_data_or_it_is_too_old("beer top 3")
    @top_beers = Rails.cache.read "beer top 3"

    # @top_styles = Style.top 3
    Rails.cache.write("style top 3", Style.top(3), expires_in: 10.minute) if cache_does_not_contain_data_or_it_is_too_old("style top 3")
    @top_styles = Rails.cache.read "style top 3"

    # @top_users = User.top 3
    Rails.cache.write("user top 3", User.top(3), expires_in: 10.minute) if cache_does_not_contain_data_or_it_is_too_old("user top 3")
    @top_users = Rails.cache.read "user top 3"
  end

  def cache_does_not_contain_data_or_it_is_too_old(cache_name)
    return false if Rails.cache.exist?(cache_name)

    true
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'Please log in to rate.'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user

    redirect_to user_path(current_user)
  end
end
