module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      self.current_user = find_verified_user
    end
  end
end
