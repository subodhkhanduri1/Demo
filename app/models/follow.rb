class Follow < ActiveRecord::Base

  attr_accessible :follower_id, :following_id

  belongs_to :following, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'#, inverse_of: :followers

  #belongs_to :followee_user, foreign_key: :id, :class_name => 'User', inverse_of: :followees

  validates_presence_of :follower
  validates_numericality_of :follower_id
  validates_presence_of :following_id
  validates_numericality_of :following_id

=begin
  def following_id
    @following_id
  end
=end
end
