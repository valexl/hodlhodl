module Hodlhodl
  module Views
    module Transactions
      class Show < Hodlhodl::View
        include Deps["repos.transaction_repo"]

        expose :transaction do |uid:|
          transaction_repo.find_by_uid!(uid)
        end
      end
    end
  end
end