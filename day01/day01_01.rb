def multiline_gets(all_text = '')
  while (text = gets) != "\n"
    all_text << text
  end
  all_text
end

puts 'Enter the frequency changes, then a blank line'
input = multiline_gets

frequency_chnanges = input.split("\n").map(&:to_i)

count = frequency_chnanges.count
resulting_frequency = frequency_chnanges.reduce(0) { |sum, x| sum + x }

puts "After #{count} changes the resulting frequency is #{resulting_frequency}"
