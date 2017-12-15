# frozen_string_literal: true

module ApplicationHelper
  def user_display_name_link(user)
    if user.known?
      link_to user.display_name, user
    else
      user.display_name
    end
  end
end
