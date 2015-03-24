require 'erb'

module Vedeu

  # Generic class to loading a template and parsing it via ERb.
  #
  class Template

    # @param object [Class]
    # @param path [String]
    # @return [void]
    def self.parse(object, path)
      new(object, path).parse
    end

    # Returns a new instance of Vedeu::Template.
    #
    # @param object [Class]
    # @param path [String]
    # @return [Template]
    def initialize(object, path)
      @object, @path = object, path.to_s
    end

    # @return [void]
    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    private

    # @!attribute [r] object
    # @return [Class]
    attr_reader :object

    # @return [String]
    def load
      File.read(path)
    end

    # @raise [MissingRequired] when the path is empty.
    # @raise [MissingRequired] when the path does not exist.
    # @return [String]
    def path
      fail MissingRequired, 'No path to template specified.' if @path.empty?
      fail MissingRequired, 'Template file cannot be found.' unless File.exist?(@path)

      @path
    end

  end # Template

end # Vedeu