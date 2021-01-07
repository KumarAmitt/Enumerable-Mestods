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

  # 3. my_all? Method--------------------------------

  def my_all?(param = nil)
    my_each do |item|
      case
      when param
        return false unless param === item
      when block_given?
        return false unless yield(item)
      else
        return false unless item
      end
    end

    true
  end

  # 4. my_any? Method--------------------------------

  def my_any?(param = nil)
    my_each do |item|
      case
      when param
        return true if param === item
      when block_given?
        return true if yield(item)
      else
        return true if item
      end
    end
    false
  end

  # 4. my_none? Method--------------------------------

  def my_none?(param = nil, &prc)
    !my_any?(param, &prc)
  end

  # 5. my_count Method--------------------------------

  def my_count(param = nil)
    count = 0
    my_each do |item|
      if block_given?
        count += 1 if yield(item)
      elsif param
        count += 1 if item == param
      else
        count = size
      end
    end

    count
  end



end
