# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  address    :text
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
  belongs_to :account
  
  validates :account, :name, presence: true
  
  default_scope { where(account_id: Account.current_id)}
end
