# frozen_string_literal: true

json.extract! newspaper, :id, :name, :display_name, :publisher_id, :created_at, :updated_at
json.url newspaper_url(newspaper, format: :json)
