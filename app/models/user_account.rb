# == Schema Information
#
# Table name: user_accounts
#
#  id         :integer          not null, primary key
#  account_id :integer
#  user_id    :integer
#  admin      :boolean          default(FALSE), not null
#  billing    :boolean          default(FALSE), not null
#

class UserAccount < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
end
