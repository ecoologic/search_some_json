# frozen_string_literal: true

module Models
  BY_TYPE = {
    users: Models::User,
    organizations: Models::Organization,
    tickets: Models::Ticket
  }.freeze
end
