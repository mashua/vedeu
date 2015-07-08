module Vedeu

  # Allows the storing of events.
  #
  # @api public
  class Events < Repository

    class << self

      alias_method :events, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.events.reset
      #
      # @return [Vedeu::Events]
      def reset!
        @events = new(Vedeu::EventCollection)
      end

    end

  end # Events

end # Vedeu