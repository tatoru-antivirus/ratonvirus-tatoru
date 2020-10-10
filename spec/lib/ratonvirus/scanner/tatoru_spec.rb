# frozen_string_literal: true

require "spec_helper"
require "ratonvirus-tatoru"

describe Ratonvirus::Scanner::Tatoru do
  describe "#virus?" do
    context "when path is nil" do
      let(:path) { nil }

      it "does not call Tatoru::Client::File.infected?" do
        expect(Tatoru::Client::File).not_to receive(:infected?)
        subject.virus?(path)
      end
    end

    context "when path is something else" do
      let(:path) { Ratonvirus::Tatoru.root.join(*%w(spec files clean.pdf)) }

      # before do
      #   # Ratonvirus needs this
      #   allow(path).to receive(:empty?).and_return(false)
      # end

      context "with Tatoru::Scanner::File.infected? returning false" do
        it "does not add any errors" do
          expect(Tatoru::Client::File).to receive(:infected?).with(path).and_return(false)
          subject.virus?(path)
          expect(subject.errors).to eq([])
        end
      end

      context "with Tatoru::Client::File.virus? returning true" do
        it "adds the antivirus_virus_detected error" do
          expect(Tatoru::Client::File).to receive(:infected?).with(path).and_return(true)
          subject.virus?(path)
          expect(subject.errors).to eq([:antivirus_virus_detected])
        end
      end

      context "with Tatoru::Client::File.infected? raising Tatoru::Client::NodeError" do
        it "adds the antivirus_client_error error" do
          expect(Tatoru::Client::File).to receive(:infected?).with(path) do
            raise Tatoru::Client::NodeError
          end
          subject.virus?(path)
          expect(subject.errors).to eq([:antivirus_client_error])
        end
      end

      context "with Tatoru::Client::File.infected? raising StandardError" do
        it "adds the antivirus_file_not_found error" do
          expect(Tatoru::Client::File).to receive(:infected?).with(path) do
            raise StandardError
          end
          expect { subject.virus?(path) }.to raise_error(StandardError)
        end
      end
    end
  end
end
