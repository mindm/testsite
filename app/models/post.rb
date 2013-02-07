# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city       :string(255)
#  state      :string(255)
#  latitude   :float
#  longitude  :float
#

class Post < ActiveRecord::Base
attr_accessible :content, :latitude, :longitude, :state, :city

belongs_to :user

validates :content, presence: true, length: { maximum: 700 }
validates :user_id, presence: true

default_scope order: 'posts.created_at DESC'
end
