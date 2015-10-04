module Vedeu

  module EscapeSequences

    # Provides border/box related escape sequences.
    #
    # @note
    #   Refer to UTF-8 U+2500 to U+257F for border characters. More
    #   details can be found at:
    #
    #   http://en.wikipedia.org/wiki/Box-drawing_character
    #
    #   Using the '\uXXXX' variant produces gaps in the border, whilst
    #   the '\xXX' renders 'nicely'.
    #
    module Borders

      extend self

      # @return [String]
      def border_on
        "\e(0".freeze
      end

      # @return [String]
      def border_off
        "\e(B".freeze
      end

      # Provides all the semigraphic characters.
      #
      # # 0 1 2 3 4 5 6 7 8 9 A B C D E F
      # 6                     ┘ ┐ ┌ └ ┼
      # 7   ─     ├ ┤ ┴ ┬ │
      #
      # @return [Hash<Symbol => String>]
      def characters
        {
          bottom_right:      "\x6A".freeze, # ┘ # \u2518
          top_right:         "\x6B".freeze, # ┐ # \u2510
          top_left:          "\x6C".freeze, # ┌ # \u250C
          bottom_left:       "\x6D".freeze, # └ # \u2514
          horizontal:        "\x71".freeze, # ─ # \u2500
          vertical_left:     "\x74".freeze, # ├ # \u251C
          vertical_right:    "\x75".freeze, # ┤ # \u2524
          horizontal_bottom: "\x76".freeze, # ┴ # \u2534
          horizontal_top:    "\x77".freeze, # ┬ # \u252C
          vertical:          "\x78".freeze, # │ # \u2502
        }
      end

      # @return [void]
      def setup!
        define_borders!
      end

      private

      # @return [void]
      def define_borders!
        characters.each { |key, code| define_method(key) { code } }
      end

    end # Borders

  end # EscapeSequences

  Vedeu::EscapeSequences::Borders.setup!

end # Vedeu
