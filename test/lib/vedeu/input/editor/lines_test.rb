require 'test_helper'

module Vedeu

  module Editor

    describe Lines do

      let(:described) { Vedeu::Editor::Lines }
      let(:instance)  { described.new(lines) }
      let(:lines)     {
        [
          Vedeu::Editor::Line.new('Some text...'),
          Vedeu::Editor::Line.new('More text...'),
          Vedeu::Editor::Line.new('Other text...')
        ]
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@lines').must_equal(lines) }

        context 'when lines were not given' do
          let(:lines) {}

          it { instance.instance_variable_get('@lines').must_equal([]) }
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:lines) }
        it { instance.must_respond_to(:lines=) }
      end

      describe '.coerce' do
        let(:document) {}

        subject { described.coerce(document) }

        it { subject.must_be_instance_of(Vedeu::Editor::Lines) }

        context 'when the document is already a Vedeu::Editor::Lines object' do
          let(:document) { Vedeu::Editor::Lines.new(lines) }

          it { subject.must_equal(document) }
          it { subject.lines.must_equal(lines) }
        end

        context 'when the document is an empty Array' do
          let(:document) { [] }

          it { subject.lines.must_equal([]) }
        end

        context 'when the document is an Array' do
          let(:document) {
            [
              Vedeu::Editor::Line.new('Some text...'),
              :more_text,
              'Other text...',
            ]
          }
          let(:expected) {
            [
              Vedeu::Editor::Line.new('Some text...'),
              Vedeu::Editor::Line.new(''),
              Vedeu::Editor::Line.new('Other text...'),
            ]
          }

          it { subject.lines.must_equal(expected) }
        end

        context 'when the document is a String' do
          let(:document) { "Some text...\nMore text..." }

          context 'but it is empty' do
            let(:document) { '' }

            it { subject.must_equal(Vedeu::Editor::Lines.new) }
          end

          context 'but it has no line breaks' do

          end
        end
      end

      describe '#delete_character' do
        let(:y) { }
        let(:x) { }

        subject { instance.delete_character(y, x) }

        it { skip }
      end

      describe '#delete_line' do
        let(:index) { 1 }

        subject { instance.delete_line(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Lines) }

        context 'when the lines are empty' do
          let(:lines) { [] }

          it { subject.must_equal(Vedeu::Editor::Lines.new) }
        end

        context 'when the lines are not empty' do
          context 'when an index is not given' do
            let(:index) {}
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when a negative index is given' do
            let(:index) { -4 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index is given' do
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index of the last line is given' do
            let(:index) { 2 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index greater than the number of lines is given' do
            let(:index) { 10 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end
        end
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the line is empty' do
          let(:lines) {}

          it { subject.must_equal(true) }
        end

        context 'when the line is not empty' do
          it { subject.must_equal(false) }
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new('Other text...') }

          it { subject.must_equal(false) }
        end
      end

      describe '#insert_character' do
        let(:character) {}
        let(:y)         {}
        let(:x)         {}

        subject { instance.insert_character(character, y, x) }

        it { skip }
      end

      describe '#insert_line' do
        let(:line)  { "Many text..." }
        let(:index) { 1 }

        subject { instance.insert_line(line, index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Lines) }

        context 'when a line is not given' do
          let(:line) {}
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...'])
          }

          it { subject.must_equal(expected) }
        end

        context 'when a line is given' do
          context 'and an index is not given' do
            let(:index) {}
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', 'Many text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'and a negative index is given' do
            let(:index) { -4 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Many text...', 'Some text...', 'More text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'and an index is given' do
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'Many text...', 'More text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'and an index of the last line is given' do
            let(:index) { 5 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', 'Many text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'and an index greater than the number of lines is given' do
            let(:index) { 10 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', 'Many text...'])
            }

            it { subject.must_equal(expected) }
          end
        end
      end

      describe '#line' do
        let(:index) { 1 }

        subject { instance.line(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when there are no lines' do
          let(:lines) {}

          it { subject.must_equal(Vedeu::Editor::Line.new) }
        end

        context 'when there are lines' do
          context 'and an index is not given' do
            let(:index) {}

            it 'returns the last line' do
              subject.must_equal(Vedeu::Editor::Line.new('Other text...'))
            end
          end

          context 'and an index is given' do
            context 'and a negative index is given' do
              let(:index) { -4 }

              it 'returns the first line' do
                subject.must_equal(Vedeu::Editor::Line.new('Some text...'))
              end
            end

            context 'and an index is given' do
              it { subject.must_equal(Vedeu::Editor::Line.new('More text...')) }
            end

            context 'and an index of the last line is given' do
              let(:index) { 5 }

              it { subject.must_equal(Vedeu::Editor::Line.new('Other text...')) }
            end

            context 'and an index greater than the number of lines is given' do
              let(:index) { 10 }

              it { subject.must_equal(Vedeu::Editor::Line.new('Other text...')) }
            end
          end
        end
      end

      describe '#size' do
        subject { instance.size }

        context 'when there are no lines' do
          let(:lines) {}

          it { subject.must_equal(0) }
        end

        context 'when there are lines' do
          it { subject.must_equal(3) }
        end
      end

    end # Lines

  end # Editor

end # Vedeu
