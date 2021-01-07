require_relative 'enumerables'

a = [5, 3, 3, 2, 4, 8, 3, 6, 5, 0, 1, 5, 1, 4, 0, 1, 0, 4, 0, 8, 4, 8, 6, 7, 8, 4, 0, 0, 6, 1, 0, 8, 4, 0, 6, 2, 4, 6, 0, 5, 3, 0, 2, 3, 4, 8, 7, 5, 6, 8, 8, 3, 0, 8, 3, 1, 8, 4, 4, 2, 6, 6, 2, 5, 6, 4, 4, 2, 3, 2, 7, 7, 1, 8, 2, 5, 4, 8, 7, 3, 1, 0, 5, 7, 1, 5, 1, 5, 1, 5, 1, 0, 0, 8, 7, 1, 1, 1, 4, 3]

range = Range.new(5, 50)

words = %w[dog door rod blade]

search = proc { |memo, word| memo.length > word.length ? memo : word }

# 1. my_each test-----------------------------

%w[A B1 c e dad ieee].my_each { |item| puts item.length }
a.my_each {|item| print item}
puts a.my_each.is_a?(Enumerator)
block = proc { |num| num < 4 }
print a.my_each(&block)
print range.my_each(&block)



