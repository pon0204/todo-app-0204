# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  deadline   :date             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  has_one_attached :eyecatch   #画像を一枚アップロード
  has_many :comments,dependent: :destroy #複数形記事と紐付け userが削除された場合、記事も削除する
  belongs_to :user
  belongs_to :board
  
end