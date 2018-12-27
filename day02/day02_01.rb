require 'pp'

# Class to manage the box IDs
class BoxId
  def initialize(id)
    @id = id
    count_characters
    calculate_frequency_distribution
  end

  # Constructs eg {"f" => 3, "a" => 2}
  def count_characters
    @character_count = Hash.new(0)
    @id.each_char do |char|
      @character_count[char] += 1
    end
    # puts @character_count
  end

  # Constructs eg {3 => ["f", "d"], 2 => ["a"]}
  def calculate_frequency_distribution
    @frequency_distribution = Hash.new(nil)
    @character_count.each do |char, count|
      repeated_letters = @frequency_distribution[count] || [] 
      repeated_letters.push char
      @frequency_distribution[count] = repeated_letters
    end
    # puts @frequency_distribution
  end

  def number_chars_that_repeat(count)
    @frequency_distribution[count] ? @frequency_distribution[count].count : nil
  end
end

# Calculate CheckSum
class ChecksumCalculator
  def initialize(ids)
    @box_ids = ids.map { |id| BoxId.new(id) }
  end

  def number_of_boxes_with_repeat_of(count)
    @box_ids.select { |box_id| box_id.number_chars_that_repeat(count) }.count
  end

  def checksum
    number_of_boxes_with_repeat_of(2) * number_of_boxes_with_repeat_of(3)
  end

end

def multiline_gets(all_text = '')
  while (text = gets) != "\n"
    all_text << text
  end
  all_text
end

puts 'Enter the box ids, then a blank line'
checksum_calculator = ChecksumCalculator.new( multiline_gets.split("\n") )
pp checksum_calculator.checksum
