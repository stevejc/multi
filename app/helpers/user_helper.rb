module UserHelper
  def user_status(user)
    if current_account.id == user.account_id
      content_tag(:span, '', class: 'glyphicon glyphicon-ok text-success')
    else
      'Invitation Pending'
    end
  end
end