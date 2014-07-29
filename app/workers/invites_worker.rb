class InvitesWorker
  include Sidekiq::Worker
  
  def perform(user_id)
    user = User.find(user_id)
    user.deliver_invitation
  end
end