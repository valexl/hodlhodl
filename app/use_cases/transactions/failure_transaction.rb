module Hodlhodl
  module UseCases
    module Transactions
      class FailureTransaction
        include Deps["repos.transaction_repo"]
        include Dry::Monads[:result]

        def call(transaction:)
          transaction_repo.transactions.where(id: transaction[:id]).update(
            status: "failure",
            updated_at: Time.now
          )

          Success(transaction)
        rescue => e
          Failure[:db_error, e.message]
        end
      end
    end
  end
end
