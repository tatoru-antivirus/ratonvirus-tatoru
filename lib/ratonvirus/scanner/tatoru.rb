# frozen_string_literal: true

module Ratonvirus
  module Scanner
    class Tatoru < Base
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
