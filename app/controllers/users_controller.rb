class UsersController < ApplicationController
  # ユーザー登録画面の表示
  # GET /users/new
  def new
    @user = User.new
  end

  # ユーザー登録処理
  # POST /users/new
  def create
    # 入力パラメーターでモデルを作成
    @user = User.new(user_params)

    # 登録しようとするユーザーIDが存在するか確認
    check = User.where("user_id = ?", @user.user_id)

    if check.count > 0
      # 同一ユーザーIDが存在する場合
      redirect_to users_new_path, alert: '既に存在するユーザーです'
      return
    end

    if @user.user_id.blank? || @user.password.blank?
      # 必須項目が入力されていない場合
      redirect_to users_new_path, alert: '必須項目が入力されていません'
      return
    end

    respond_to do |format|
      if @user.save
        # 登録に成功した場合
        format.html { redirect_to root_path, notice: 'ユーザーを登録しました' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # パラメーター許可
    def user_params
     params.require(:user).permit(:user_id, :password)
    end
end
