# frozen_string_literal: true

module Hodlhodl
  module Actions
    module Transactions
      class Show < Hodlhodl::Action
        def handle(request, response)
          response.render(view, uid: request.params[:uid])
        rescue ROM::TupleCountMismatchError
          response.status = 404
          response.render(error_view)
        end

        private

        def view = Hodlhodl::Views::Transactions::Show.new
      end
    end
  end
end
