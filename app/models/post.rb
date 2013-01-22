# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
attr_accessible :content

belongs_to :user

validates :content, presence: true, length: { maximum: 70 }
validates :user_id, presence: true

default_scope order: 'posts.created_at DESC'
end
