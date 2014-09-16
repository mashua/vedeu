module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  class Cursor

    extend Forwardable

    def_delegators :geometry, :top, :right, :bottom, :left

    # Provides a new instance of Cursor.
    #
    # @param attributes [Hash] The stored attributes for a cursor.
    # @return [Cursor]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @name  = @attributes[:name]
      @state = @attributes[:state]
      @x     = @attributes[:x]
      @y     = @attributes[:y]
    end

    # Returns an attribute hash for the current position and visibility of the
    # cursor.
    #
    # @return [Hash]
    def attributes
      {
        name:  name,
        state: state,
        x:     x,
        y:     y,
      }
    end
    alias_method :refresh, :attributes

    # Move the cursor up one row.
    #
    # @return [Cursor]
    def move_up
      unless y == top || y - 1 < top
        @y -= 1
      end

      attributes
    end

    # Move the cursor down one row.
    #
    # @return [Cursor]
    def move_down
      unless y == bottom || y + 1 >= bottom
        @y += 1
      end

      attributes
    end

    # Move the cursor left one column.
    #
    # @return [Cursor]
    def move_left
      unless x == left || x - 1 < left
        @x -= 1
      end

      attributes
    end

    # Move the cursor right one column.
    #
    # @return [Cursor]
    def move_right
      unless x == right || x + 1 >= right
        @x += 1
      end

      attributes
    end

    # Make the cursor visible if it is not already.
    #
    # @return [Symbol]
    def show
      @state = :show

      attributes
    end

    # Make the cursor invisible if it is not already.
    #
    # @return [Symbol]
    def hide
      @state = :hide

      attributes
    end

    # Toggle the visibility of the cursor.
    #
    # @return [Symbol]
    def toggle
      if visible?
        @state = :hide

      else
        @state = :show

      end

      attributes
    end

    # Returns an escape sequence to position the cursor and set its visibility.
    # When passed a block, will position the cursor, yield and return the
    # original position.
    #
    # @param block [Proc]
    # @return [String]
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end

    private

    attr_reader :name, :state

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @api private
    # @return [String]
    def sequence
      [ position, visibility ].join
    end

    # Returns the escape sequence to position the cursor.
    #
    # @api private
    # @return [String]
    def position
      ["\e[", y, ';', x, 'H'].join
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @api private
    # @return [String]
    def visibility
      return Esc.string('show_cursor') if visible?

      Esc.string('hide_cursor')
    end

    # Return a boolean indicating the visibility of the cursor, invisible if
    # the state is not defined.
    #
    # @api private
    # @return [Boolean]
    def visible?
      return false unless states.include?(state)
      return false if state == :hide

      true
    end

    # Returns the y coordinate of the cursor, unless out of range, in which case
    # sets y to the first row (top) of the interface.
    #
    # @api private
    # @return [Fixnum]
    def y
      if y_out_of_range?
        @y = top

      else
        @y

      end
    end

    # Returns the x coordinate of the cursor, unless out of range, in which case
    # sets x to the first column (left) of the interface.
    #
    # @api private
    # @return [Fixnum]
    def x
      if x_out_of_range?
        @x = left

      else
        @x

      end
    end

    # Returns a boolean indicating whether the previous y coordinate is still
    # inside the interface or terminal.
    #
    # @api private
    # @return [Boolean]
    def y_out_of_range?
      @y < top || @y > bottom
    end

    # Returns a boolean indicating whether the previous x coordinate is still
    # inside the interface or terminal.
    #
    # @api private
    # @return [Boolean]
    def x_out_of_range?
      @x < left || @x > right
    end

    # Returns the position and size of the interface.
    #
    # @api private
    # @return [Geometry]
    def geometry
      @geometry ||= Vedeu::Geometry.new(interface[:geometry])
    end

    # Returns the attributes of a named interface.
    #
    # @api private
    # @return [Hash]
    def interface
      Vedeu::Interfaces.find(name)
    end

    # The valid visibility states for the cursor.
    #
    # @api private
    # @return [Array]
    def states
      [:show, :hide]
    end

    # The default values for a new instance of Cursor.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        name:  '',
        x:     1,
        y:     1,
        state: :hide,
      }
    end
  end

end
