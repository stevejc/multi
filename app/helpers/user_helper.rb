module UserHelper
  def user_status(user)
    if current_account.owner == user || user.invitation_accepted?
      content_tag(:span, '', class: 'glyphicon glyphicon-ok text-success')
    end
  end
end

