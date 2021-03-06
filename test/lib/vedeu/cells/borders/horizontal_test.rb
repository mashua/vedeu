# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Horizontal do

      let(:described) { Vedeu::Cells::Horizontal }
      let(:instance)  { described.new }

      describe '#as_html' do
        subject { instance.as_html }

        it { subject.must_equal('&#x2500;') }
      end

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal('-') }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:horizontal) }
      end

    end # Horizontal

  end # Cells

end # Vedeu
