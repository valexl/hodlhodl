module Hodlhodl
  module Relations
    class Transactions < Hodlhodl::DB::Relation
      schema :transactions, infer: true
    end
  end
end
