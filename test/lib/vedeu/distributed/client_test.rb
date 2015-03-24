require 'test_helper'

module Vedeu

  module Distributed

    describe Client do

      let(:described) { Vedeu::Distributed::Client }
      let(:instance)  { described.new(uri) }
      let(:uri)       { 'druby://localhost:21420' }

      before { $stdout.stubs(:puts) }

      describe 'alias methods' do
        it { instance.must_respond_to(:read) }
        it { instance.must_respond_to(:write) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@uri').must_equal('druby://localhost:21420') }
      end

      describe '.connect' do
        subject { described.connect(uri) }

        context 'when the DRb server is not available or not enabled' do
          it { subject.must_equal(:drb_connection_error) }
        end
      end

      describe '#input' do
        let(:data) {}

        subject { instance.input(data) }

        context 'when the DRb server is not available or not enabled' do
          it { subject.must_equal(:drb_connection_error) }
        end
      end

      describe '#output' do
        subject { instance.output }

        context 'when the DRb server is not available or not enabled' do
          it { subject.must_equal(:drb_connection_error) }
        end
      end

      describe '#shutdown' do
        subject { instance.shutdown }

        context 'when the DRb server is not available or not enabled' do
          it { subject.must_equal(:drb_connection_error) }
        end
      end

    end # Client

  end # Distributed

end # Vedeu