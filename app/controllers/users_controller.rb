class UsersController < ApplicationController
  layout "main"
  
  def index
    list
    render :action => 'list'
  end

  def list
    # nothing here
  end

  def details
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
