class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
    @beer_clubs = BeerClub.all
  end

  def new
    @membership = Membership.new
    @memberships = Membership.all
    @membership.user = current_user
    @beer_clubs = BeerClub.all - current_user.beer_clubs
  end

  def create
    @membership = Membership.create params.require(:membership).permit(:beer_club_id, :user_id)
    @beer_clubs = BeerClub.all
    @membership.user = current_user
    if @membership.save
      redirect_to user_path current_user
    else
      @memberships = Membership.all
      render :new
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.delete
    redirect_to user_path(current_user)
  end
end
