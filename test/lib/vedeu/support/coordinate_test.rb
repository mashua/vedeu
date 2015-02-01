require 'test_helper'

module Vedeu

  describe Coordinate do

    let(:described) { Vedeu::Coordinate }
    let(:instance)  { described.new(height, width, x, y) }
    let(:height)    { 6 }
    let(:width)     { 6 }
    let(:x)         { 7 }
    let(:y)         { 5 }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@height').must_equal(height) }
      it { subject.instance_variable_get('@width').must_equal(width) }
      it { subject.instance_variable_get('@x').must_equal(x) }
      it { subject.instance_variable_get('@y').must_equal(y) }
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal('<Vedeu::Coordinate (height:6 width:6 x:7 y:5)>') }
    end

    describe '#y_position' do
      let(:index)  { 0 }
      let(:height) { 6 }
      let(:width)  { 6 }
      let(:x)      { 7 }
      let(:y)      { 5 }

      subject { instance.y_position(index) }

      it { subject.must_be_instance_of(Fixnum) }

      context 'with a negative index' do
        let(:index) { -3 }

        it { subject.must_equal(5) }
      end

      context 'with an index greater than the maximum index for y' do
        let(:index) { 9 }

        it { subject.must_equal(11) }

        context 'but the height is negative' do
          let(:height) { -2 }

          it { subject.must_equal(0) }
        end
      end

      context 'with an index within range' do
        let(:index) { 3 }

        it { subject.must_equal(8) }
      end
    end

    describe '#x_position' do
      let(:index)  { 0 }
      let(:height) { 6 }
      let(:width)  { 6 }
      let(:x)      { 7 }
      let(:y)      { 5 }

      subject { instance.x_position(index) }

      it { subject.must_be_instance_of(Fixnum) }

      context 'with a negative index' do
        let(:index) { -3 }

        it { subject.must_equal(7) }
      end

      context 'with an index greater than the maximum index for x' do
        let(:index) { 9 }

        it { subject.must_equal(13) }

        context 'but the width is negative' do
          let(:width) { -2 }

          it { subject.must_equal(0) }
        end
      end

      context 'with an index within range' do
        let(:index) { 3 }

        it { subject.must_equal(10) }
      end
    end

  end # Coordinate

end # Vedeu
