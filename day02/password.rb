module Password
  extend self

  def valid_count(filepath, valid_method)
    File.readlines(filepath).inject(0) do |sum, line|
      sum += 1 if send(valid_method, line)
      sum
    end
  end

  def valid?(rule_with_password)
    rule = rule_with_password.split(":").first

    expected_range = rule.split(" ").first
    min_valid_count = expected_range.split("-").first.to_i
    max_valid_count = expected_range.split("-").last.to_i
    rule_letter = rule.split(" ").last

    password = rule_with_password.split(":").last.strip
    password.count(rule_letter) >= min_valid_count && password.count(rule_letter) <= max_valid_count
  end

  def toboggan_valid?(rule_with_password)
    rule = rule_with_password.split(":").first

    expected_range = rule.split(" ").first
    idx1 = expected_range.split("-").first.to_i
    idx2 = expected_range.split("-").last.to_i
    rule_letter = rule.split(" ").last

    password = rule_with_password.split(":").last.strip

    password[idx1-1] != password[idx2-1] &&
    (password[idx1-1] == rule_letter || password[idx2-1] == rule_letter)
  end
end


############### Tests

puts "Test: valid?"
[
  ["1-3 a: abcde", true],
  ["1-3 b: cdefg", false],
  ["2-9 c: ccccccccc", true]
].each do |password_str, expected_validity|
  if Password.valid?(password_str) == expected_validity
    puts "🙌: #{password_str}"
  else
    puts "💥: #{password_str}"
  end
end

puts "Test: toboggan_valid?"
[
  ["1-3 a: abcde", true],
  ["1-3 b: cdefg", false],
  ["2-9 c: ccccccccc", false]
].each do |password_str, expected_validity|
  if Password.toboggan_valid?(password_str) == expected_validity
    puts "🙌: #{password_str}"
  else
    puts "💥: #{password_str}"
  end
end


puts "test_input.txt should equal 2"
puts Password.valid_count('./test_input.txt', 'valid?')

puts "Part 1"
puts Password.valid_count('./input1.txt', 'valid?')

puts "test_input.txt should equal 1"
puts Password.valid_count('./test_input.txt', 'toboggan_valid?')

puts "Part 2"
puts Password.valid_count('./input1.txt', 'toboggan_valid?')