# frozen_string_literal: true

module Ratonvirus
  module Scanner
    class Tatoru < Base
      class << self
        def executable?
          ::Tatoru::Client::Node.new.ready?
        end
      end

      protected

      def run_scan(path)
        begin
          errors << :antivirus_virus_detected if ::Tatoru::Client::File.infected?(path)
        rescue ::Tatoru::Client::NodeError => e
          errors << :antivirus_client_error
        end
      end
    end
  end
end
