module Hodlhodl
  module Repos
    class TransactionRepo < Hodlhodl::DB::Repo
      commands :create, :update

      def find_by_uid!(uid)
        transactions.where(uid: uid).one!
      end

      def find_by_uid(uid)
        transactions.where(uid: uid).one
      end
    end
  end
end