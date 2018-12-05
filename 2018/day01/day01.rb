class Frequency
  attr_accessor :state

  def initialize
    @state = 0
  end

  def stabilize(collection)
    collection.each do |change|
      adjust(change)
    end
  end

  private

  def adjust(change)
    self.state = self.state + change.to_i
  end
end

class Processor
  def self.run!
    input = self.read_input('day01-input.txt')
    data  = self.sanitize_input(input)

    freq = Frequency.new
    freq.stabilize(data)

    puts "Frequency stabilized at: #{freq.state.to_s}"
    exit 0
  end

  def self.sanitize_input(input)
    input.map { |i| i.chomp! }
  end

  def self.read_input(filename)
    @_content ||= File.readlines(filename)
  end
end

Processor.run!

require 'rspec'
describe Frequency do
  context 'stabilizing' do
    it 'example 1' do
      frequency_changes = ['+1', '+1', '+1']
      freq = Frequency.new
      freq.stabilize(frequency_changes)

      expect(freq.state).to eq(3)
    end

    it 'example 2' do
      frequency_changes = ['+1', '+1', '-2']
      freq = Frequency.new
      freq.stabilize(frequency_changes)

      expect(freq.state).to eq(0)
    end

    it 'example 3' do
      frequency_changes = ['-1', '-2', '-3']
      freq = Frequency.new
      freq.stabilize(frequency_changes)

      expect(freq.state).to eq(-6)
    end
  end
end

describe Processor do
  context '.sanitize_input' do
    it 'removes newline characters' do
      data =  ["+4\n", "+9\n", "+17\n"]
      expect(Processor.sanitize_input(data)).to eq(["+4", "+9", "+17"])
    end
  end
end
