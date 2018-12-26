# Helper class for day 1 part 2 of advent of code
class Day0102
  def initialize
    @current = 0
    @previous = []
    @repeated_frequency = nil
  end

  def multiline_gets(all_text = '')
    while (text = gets) != "\n"
      all_text << text
    end
    all_text
  end

  def check_for_frequency_repeat(changes)
    puts "scanning #{changes.count} frequencies starting at #{@current}"
    changes.each do |frequency_shift|
      @current += frequency_shift

      if @previous.include?(@current)
        @repeated_frequency = @current
        break
      else
        @previous.push @current
      end
    end
  end

  def find_frequency
    puts 'Enter the frequency changes, then a blank line'
    changes = multiline_gets.split("\n").map(&:to_i)

    check_for_frequency_repeat(changes) while @repeated_frequency.nil?

    puts "The first repeated frequency is #{@repeated_frequency}"
  end
end

Day0102.new.find_frequency
