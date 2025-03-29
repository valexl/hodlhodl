module Hodlhodl
  module Guards
    module Transactions
      class EmailGuard
        def self.call(email)
          return "email is required" if email.to_s.strip.empty?
          return "must be a valid email" unless email =~ URI::MailTo::EMAIL_REGEXP

          nil
        end
      end
    end
  end
end
