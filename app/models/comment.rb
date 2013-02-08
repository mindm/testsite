# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  post_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :user_id, :content, :post_id

  validates :post_id,  presence: true
  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 700 }
  
end
