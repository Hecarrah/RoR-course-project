class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
    @beer_clubs = BeerClub.all
  end

  def confirm
    membership = Membership.find(params[:id])
    membership.update_attribute :confirmed, true

    redirect_to membership.beer_club, notice: "User confirmed"
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
      redirect_to beer_club_path(@membership.beer_club), notice: "Applied to the club, #{current_user.username}"
    else
      @memberships = Membership.all
      render :new
    end
  end

  def destroy
    membership = Membership.find_by(beer_club_id: params.require(:membership).permit(:beer_club_id).values, user_id: current_user.id)
    membership.delete
    redirect_to user_path(current_user), notice: "Succesfully ended the membership with the club, #{BeerClub.find(membership.beer_club_id).name}"
  end
end
