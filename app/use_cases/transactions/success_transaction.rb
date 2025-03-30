# frozen_string_literal: true

require "dry/monads"

module Hodlhodl
  module UseCases
    module Transactions
      class SuccessTransaction
        include Deps["repos.transaction_repo"]
        include Dry::Monads[:result]

        def call(transaction:, txid:)
          transaction_repo.transactions.where(id: transaction[:id]).update(
            status: "success",
            txid: txid,
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
