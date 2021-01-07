module Enumerable

  # 1. my_each Method-----------------------------

  def my_each
    return to_enum(:my_each) unless block_given?

    to_a.length.times do |i|
      yield to_a[i]
    end

    self
  end


  # 2. my_each_with_index Method-----------------------------

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    to_a.length.times do |i|
      yield to_a[i], [i]
    end

    self
  end

  # 2. my_select Method-----------------------------
  
  def my_select
    return to_enum(:my_select) unless block_given?

    selects = []

    to_a.my_each { |item| selects << item if yield(item) }

    selects
  end



end
