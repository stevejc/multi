# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
  cattr_accessor :current_id
  has_many :users
  belongs_to :owner, class_name: 'User'

  validates :owner, presence: true


  accepts_nested_attributes_for :owner
      

end
