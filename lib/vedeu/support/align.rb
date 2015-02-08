module Vedeu

  # Align a string (or object responding to `to_s`).
  #
  class Align

    # @see Vedeu::DSL::Stream#align
    def self.with(value = '', options = {})
      new(value, options).aligned
    end

    # Returns a new instance of Align.
    #
    # @param value [String]
    # @param options [Hash]
    # @option options width [Integer]
    # @option options anchor [Symbol] See {Align#anchor}
    # @option options pad [String]
    # @return [Align]
    def initialize(value = '', options = {})
      @value   = value
      @options = defaults.merge(options)
    end

    # Aligns the value.
    #
    # @return [String]
    def aligned
      return string unless width

      return truncated if truncate?

      case anchor
      when :align, :left, :text then left
      when :centre, :center     then centre
      when :right               then right
      else
        left
      end
    end

    private

    attr_reader :value, :options

    # @return [Symbol] One of :align, :centre, :center, :left, :right, :text
    def anchor
      options[:anchor]
    end

    def centre
      string.center(width, pad)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        anchor: :left,
        pad:    ' ',
        width:  nil,
      }
    end

    def left
      string.ljust(width, pad)
    end

    def pad
      options[:pad]
    end

    def right
      string.rjust(width, pad)
    end

    def string
      value.to_s
    end

    def truncate?
      string.size > width
    end

    def truncated
      string.slice(0, width)
    end

    def width
      options[:width]
    end

  end # Align

end # Vedeu
