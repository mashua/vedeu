module Vedeu

  module Input

    # Rudimentary support for mouse interactions.
    #
    class Mouse

      # Trigger an event depending on which button was pressed.
      #
      # @param input [String]
      # @return [void]
      def self.click(input)
        new(input).click
      end

      # Return an instance of Vedeu::Input::Mouse.
      #
      # @param input [String]
      # @return [Vedeu::Input::Mouse]
      def initialize(input)
        @input = input
      end

      # Trigger an event depending on which button was pressed.
      #
      # @return [void]
      def click
        Vedeu.log(type:    :input,
                  message: "Mouse pressed: '#{button}' (x: #{x}, y: #{y})")

        if left_click?
          Vedeu.trigger(:_cursor_reposition_, Vedeu.focus, y, x)

        elsif wheel_up?
          Vedeu.trigger(:_cursor_up_, Vedeu.focus)

        elsif wheel_down?
          Vedeu.trigger(:_cursor_down_, Vedeu.focus)

        else
          Vedeu.log(type:    :input,
                    message: 'Vedeu does not support mouse button ' \
                             "'#{button}' yet.")

        end
      end

      protected

      # @!attribute [r] input
      # @return [String]
      attr_reader :input

      private

      # @return [Fixnum]
      def button
        mouse[0]
      end

      # @return [Array<Fixnum>]
      def mouse
        @_input ||= input.chars[3..-1].map { |character| character.ord - 32 }
      end

      # @return [Boolean]
      def left_click?
        button == 0
      end

      # @return [Boolean]
      def wheel_up?
        button == 64
      end

      # @return [Boolean]
      def wheel_down?
        button == 65
      end

      # @return [Fixnum]
      def x
        mouse[1]
      end

      # @return [Fixnum]
      def y
        mouse[2]
      end

    end # Mouse

  end # Input

end # Vedeu