module Vedeu

  # Clears all the character data for the area defined by an interface. This
  # class is called every time an interface is rendered to prepare the area
  # for new data.
  #
  # @api private
  class Clear

    # Blanks the area defined by the interface.
    #
    # @param interface [Interface]
    # @return [String]
    def self.call(interface)
      new(interface).clear
    end

    # Returns a new instance of Clear.
    #
    # @param interface [Interface]
    # @return [Clear]
    def initialize(interface)
      @interface = interface
    end

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [String]
    def clear
      Vedeu.log("Clearing view: '#{interface.name}'")

      rows.inject([colours]) do |line, index|
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    private

    attr_reader :interface

    # @return [String]
    def colours
      interface.colour.to_s
    end

    # @return [Enumerator]
    def rows
      interface.height.times
    end

  end # Clear

end # Vedeu