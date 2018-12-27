require 'pp'
require 'pry'

# Class to manage the box IDs
class BoxId
  attr_reader :id

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

  def chars_in_common_with(other_box_id)
    chars_in_common = []
    id_chars = @id.chars
    other_chars = other_box_id.chars
    id_chars.each_index do |index|
      current_char = id_chars[index]
      chars_in_common.push current_char if current_char == other_chars[index]
    end
    chars_in_common
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

# Checks for two boxes with n-1 characters in common
class BoxComparer
  def initialize(ids)
    @box_ids = ids.map { |id| BoxId.new(id) }
  end

  def search_for_match
    for i in 0..@box_ids.length - 1
      for j in (i+1)..@box_ids.length - 1
        common_string = @box_ids[i].chars_in_common_with(@box_ids[j].id)
        return common_string if common_string.length == @box_ids[i].id.length - 1 
      end
    end
  end
end

def multiline_gets(all_text = '')
  while (text = gets) != "\n"
    all_text << text
  end
  all_text
end

 puts 'Enter the box ids, then a blank line'
 box_comparer = BoxComparer.new( multiline_gets.split("\n") )
 puts box_comparer.search_for_match.join
