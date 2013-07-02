class Tweet < ActiveRecord::Base

  attr_accessible :user_id, :message

  belongs_to :user, class_name: 'User'

  validates_presence_of :user
  validates_numericality_of :user_id
  validates_presence_of :message
  validates_length_of :message, :maximum => 200

  def username
    User.find_by_id(self.user_id).username
  end

  def name
    User.find_by_id(self.user_id).name
  end

end