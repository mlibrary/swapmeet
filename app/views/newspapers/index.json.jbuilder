# frozen_string_literal: true

json.array! @newspapers, partial: 'newspapers/newspaper', as: :newspaper
