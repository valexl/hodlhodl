# frozen_string_literal: true

module Web
  module Actions
    module Home
      class Index < Web::Action
        def handle(*, response)
          response.render(view)
        end

        private

        def view = Web::Views::Home::Index.new
      end
    end
  end
end
