class Students::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_user, except: [:index, :new]
  before_action :valid_image_avatar, only: [:create, :update]

  def index
    @users = User.recent.page(params[:page])
      .per Settings.per_page.students.user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      create_activity_for_user
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to students_users_path
    else
      render :new
    end
  end

  def show

  end

  def edit; end

  def update
    if @user.update_attributes user_params
      create_activity_for_user
      flash[:success] = t "devise.registrations.updated"
      redirect_to students_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      create_activity_for_user
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to students_users_path
  end

  private

  def valid_image_avatar
    if params[:user][:avatar].present?
      unless Settings.image_types.to_h.values.include? File.extname(
        params[:user][:avatar].original_filename).split(".").last.downcase
        flash[:error] = t "dashboard.users.format_type_image_invalid"
        redirect_to :back
      end
    end
  end


  def user_params
    params.require(:user)
    .permit(:email, :name, :employee_code, :gender, :avatar, :birthday,
      :role, :account_creation_date, :address, :number_of_phone)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t "dashboard.users.not_found"
    redirect_to students_users_path
  end
end
