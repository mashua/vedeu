require 'json'
require 'virtus'

require_relative 'attributes/interface_collection'

module Vedeu
  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def to_json
      {
        interfaces: interfaces
      }.to_json
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end
