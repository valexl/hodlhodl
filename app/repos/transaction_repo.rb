module Hodlhodl
  module Repos
    class TransactionRepo < Hodlhodl::DB::Repo
      def find_by_uid!(uid)
        transactions.where(uid: uid).one!
      end
    end
  end
end