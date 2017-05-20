class Admins::UsersController < DashboardController
  before_action :load_user, except: [:index, :new, :create]
  before_action :valid_image_avatar, only: [:create, :update]
  load_and_authorize_resource
  before_action :authenticate_admin!

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.recent.page(params[:page])
      .per Settings.per_page.admins.user
    @roles = User.roles
    if request.xhr?
      respond_to do |format|
        format.js{}
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params.merge!(password: "123456")
    if @user.save
      create_activity_for_user
      flash[:success] = "Thêm thành viên thành công"
      redirect_to admins_users_path
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
      flash[:success] = "Cập nhật thành viên thành công"
      redirect_to admins_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      # create_activity_for_user
      flash[:success] = "Xóa thành viên thành công"
    else
      flash[:warning] = "Xóa thành viên không thành công"
    end
    redirect_to admins_users_path
  end

  private

  def valid_image_avatar
    if params[:user][:avatar].present?
      unless Settings.image_types.to_h.values.include? File.extname(
        params[:user][:avatar].original_filename).split(".").last.downcase
        flash[:error] = "Ảnh không đúng định dạng"
        redirect_to :back
      end
    end
  end


  def user_params
    params.require(:user).permit(:email, :name, :gender, :avatar,
      :birthday, :role, :address, :number_of_phone)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = "Không tìm thấy thành viên"
    redirect_to admins_users_path
  end

  def create_activity_for_user
    create_activity User.name, @user, @_action_name
  end
end
