# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  owner_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  plan       :string(255)      default("gold"), not null
#  phone      :string(255)
#  email      :string(255)
#  address    :text
#  time_zone  :string(255)
#

class Account < ActiveRecord::Base
  cattr_accessor :current_id

  belongs_to :owner, class_name: 'User'
  has_many :user_accounts, dependent: :destroy
  has_many :users, through: :user_accounts
  has_many :clients, dependent: :destroy

  validates :owner, presence: true
  validates :name, presence: true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  accepts_nested_attributes_for :owner
      

end
