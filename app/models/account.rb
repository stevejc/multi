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
      RESTRICTED_SUBDOMAINS = %w(www)
      has_one :user
      belongs_to :owner, class_name: 'User'

      validates :owner, presence: true


      accepts_nested_attributes_for :owner

      before_validation :downcase_subdomain
      

end
