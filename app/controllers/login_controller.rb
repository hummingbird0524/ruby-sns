class LoginController < ApplicationController
  # ログイン処理
  # POST /login
  def login
    # 入力されたユーザーID＆パスワードで検索
    @user = User.where("user_id = ? AND password = ?", params[:user_id], params[:password])

    if @user.count > 0
      # 取得できた場合(ユーザーID＆パスワード一致)

      # セッションにユーザーIDを登録
      session[:user_id] = params[:user_id]

      # 記事一覧に遷移
      redirect_to posts_path
    else
      # 取得できなかった場合(いずれか不一致)

      # トップ画面に遷移
      redirect_to root_path, alert: 'ログインに失敗しました'
    end
  end

  # ログアウト処理
  # DELETE /logout
  def logout
    reset_session
    redirect_to root_path
  end

  private
    def login_params
      params.require(:user).permit(:user_id, :password)
    end
end
