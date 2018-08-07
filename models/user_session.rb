class UserSession < Authlogic::Session::Base
  #logout_on_timeout Rails.env.production?
   #logout_on_timeout Rails.env.development?
#  self.logout_on_timeout = true
end