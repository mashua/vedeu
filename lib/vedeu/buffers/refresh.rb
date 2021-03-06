# frozen_string_literal: true

module Vedeu

  module Buffers

    # Refreshes the given named interface.
    #
    # @api private
    #
    class Refresh

      include Vedeu::Common

      # {include:file:docs/events/by_name/refresh_view.md}
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name = Vedeu.focus)
        new(name).by_name
      end

      # Return a new instance of Vedeu::Buffers::Refresh.
      #
      # @macro param_name
      # @return [Vedeu::Buffers::Refresh]
      def initialize(name = Vedeu.focus)
        @name = name || Vedeu.focus
      end

      # @return [Array|Vedeu::Error::ModelNotFound]
      def by_name
        Vedeu.clear_content_by_name(name)

        buffer.render

        Vedeu.trigger(:_refresh_border_, name)
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @macro buffer_by_name
      def buffer
        Vedeu.buffers.by_name(name)
      end

    end # Refresh

  end # Buffers

end # Vedeu
