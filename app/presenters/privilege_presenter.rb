# frozen_string_literal: true

class PrivilegePresenter < ApplicationPresenter
  delegate :permit?, :revoke?, to: :policy
end
