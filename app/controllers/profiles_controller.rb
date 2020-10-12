class ProfilesController < ApplicationController
  
  def show
    @profile = current_user.profile #user.rbにてhas?oneをしている為取得できている
    end
  
  def edit
    # if current_user.profile.present? 
    #   @profile = current_user.profile #userのプロフォールを取得し、edit画面に表示する
    # else
    #   @profile = current_user.build_profile #has_one　の場合 build_変数    
    # end
    @profile = current_user.prepare_profile #もしカレントユーザーのプロフィールがあったら取得 ||はオアーの分岐
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params) #上の値にパラメータを追加出来る様になる
    if @profile.save
        redirect_to profile_path, notice: 'プロフィール更新!'
    else
      falsh.now[:error] = '更新出来ませんでした'
      render :edit
    end
  end


  private
  def profile_params 
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
    )
  end
  
end
