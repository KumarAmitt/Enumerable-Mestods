require_relative 'enumerables'

a = [5, 3, 3, 2, 4, 8, 3, 6, 5, 0, 1, 5, 1, 4, 0, 1, 0, 4, 0, 8, 4, 8, 6, 7, 8, 4, 0, 0, 6, 1, 0, 8, 4, 0, 6, 2, 4, 6, 0, 5, 3, 0, 2, 3, 4, 8, 7, 5, 6, 8, 8, 3, 0, 8, 3, 1, 8, 4, 4, 2, 6, 6, 2, 5, 6, 4, 4, 2, 3, 2, 7, 7, 1, 8, 2, 5, 4, 8, 7, 3, 1, 0, 5, 7, 1, 5, 1, 5, 1, 5, 1, 0, 0, 8, 7, 1, 1, 1, 4, 3]

range = Range.new(5, 50)

words = %w[dog door rod blade]

search = proc { |memo, word| memo.length > word.length ? memo : word }

puts '1. my_each test-----------------------------'

%w[A B1 c e dad ieee].my_each { |item| puts item.length }
a.my_each { |item| print item }
puts a.my_each.is_a?(Enumerator)
block = proc { |num| num < 4 }
print a.my_each(&block)
print range.my_each(&block)

puts "\n\n"
puts '2. my_each_with_index test-----------------------------'

%w[any k a b c d e].my_each_with_index { |item, index| puts "#{item} : #{index}" }
a.my_each_with_index { |item, index| puts "#{item} & #{index}" }
puts a.my_each_with_index.is_a?(Enumerator)
block = proc { |num| num < 4 }
print a.my_each_with_index(&block)

puts "\n\n"
puts '3. my_select test-----------------------------'

print(a.my_select(&:even?))
print a.my_select.is_a?(Enumerator)

puts "\n\n"
puts '4. my_all? test-----------------------------'

puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=>true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=>false
puts %w[ant bear cat].my_all?(/t/) #=>false
puts [1, 2i, 3.14].my_all?(Numeric) #=>true
puts [nil, true, 99].my_all? #=>false
puts [].my_all? #=>true
puts a.my_all?(3) #=>false
puts [1, 'hi', true, []].my_all? #=>true

puts "\n\n"
puts '5. my_any? test-----------------------------'


puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false
puts words.my_any?('cat') #=> false
puts [nil, false].my_any? #=> false

puts "\n\n"
puts '6. my_none? test-----------------------------'

puts %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_none?(/d/) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false
puts words.my_none?(5) #=> true
puts [3, 4, 7, 11].my_none?(4) #=> false



puts "\n\n"
puts '7. my_count test-----------------------------'

ary = [1, 2, 4, 2]
puts ary.my_count #=> 4
puts ary.my_count(2) #=> 2
puts(ary.my_count(&:even?)) #=> 3
puts range.my_count #=> 46


puts "\n\n"
puts '8. my_map test-----------------------------'

print (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
random_proc = proc { |num| num * 2 }
print (1..4).my_map(random_proc) #=> [2, 4, 6, 8]
puts a.my_map.is_a?(Enumerator) #=> true
my_proc = proc { |num| num > 10 }
print a.my_map(my_proc) { |num| num < 10 }

puts "\n\n"
puts '9. my_inject test-----------------------------'

# Sum some numbers
puts (5..10).my_inject(:+) #=> 45
# Same using a block and inject
puts (5..10).my_inject { |sum, n| sum + n } #=> 45
# Multiply some numbers
puts (5..10).my_inject(1, :*) #=> 151200
# Same using a block
puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200

puts range.my_inject(:*)
puts range.my_inject(2, :*)

search = proc { |memo, word| memo.length > word.length ? memo : word }
words = %w[dog doooooor rod blade]

puts words.my_inject(&search)

puts "\n\n"
puts '10. multiply_els test-----------------------------'

puts multiply_els([2, 4, 5])



