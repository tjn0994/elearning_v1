class Teachers::UsersController < DashboardController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_user, only: [:show, :edit, :update]
  before_action :valid_image_avatar, only: :update

  def show;end

  def edit; end

  def update
    if @user.update_attributes user_params
      create_activity_for_user
      flash[:success] = "Cập nhật thành công"
      redirect_to teachers_user_path
    else
      render :edit
    end
  end

  private

  def valid_image_avatar
    if params[:user][:avatar].present?
      unless Settings.image_types.to_h.values.include? File.extname(
        params[:user][:avatar].original_filename).split(".").last.downcase
        flash[:error] = "Ảnh quá lớn"
        redirect_to :back
      end
    end
  end

  def user_params
    params.require(:user)
    .permit(:email, :name, :gender, :avatar, :birthday, :address, :number_of_phone)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = "Không tìm thấy người dùng"
    redirect_to root_path
  end
end
