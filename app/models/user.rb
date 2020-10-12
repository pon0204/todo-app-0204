# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :boards, dependent: :destroy #複数形記事と紐付け userが削除された場合、記事も削除する
         has_one :profile, dependent: :destroy  #一つの意味 プロフィールを所有している

         def prepare_profile
          profile || build_profile #もしカレントユーザーのプロフィールがあったら取得 ||はオアーの分岐
        end
        
        def avatar_image
          if profile&.avatar&.attached? #アタッチであ風ロードされているかを確認
            profile.avatar
          else
            'default-avatar.png'
          end
        end
end
