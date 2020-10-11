require "ratonvirus"
require "tatoru_client"

require_relative "scanner/tatoru"

module Ratonvirus
  module Tatoru
    def self.root
      Pathname.new( ::File.expand_path(::File.join(::File.dirname(__FILE__), "..", "..")) )
    end
  end
end
