module Enumerable
  # 1. my_each Method-----------------------------

  def my_each
    return to_enum(:my_each) unless block_given?

    arr = *self

    arr.length.times do |i|
      yield arr[i]
    end

    self
  end

  # 2. my_each_with_index Method-----------------------------

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = *self

    arr.length.times do |i|
      yield arr[i], i
    end

    self
  end

  # 3. my_select Method-----------------------------

  def my_select
    return to_enum(:my_select) unless block_given?

    selects = []

    to_a.my_each { |item| selects << item if yield(item) }

    selects
  end

  # 4. my_all? Method--------------------------------

  def my_all?(param = nil)
    my_each do |item|
      case
      when param
        return false unless param === item # rubocop:disable Style/CaseEquality
      when block_given?
        return false unless yield(item)
      else
        return false unless item
      end
    end

    true
  end

  # 5. my_any? Method--------------------------------

  def my_any?(param = nil)
    my_each do |item|
      case
      when param
        return true if param === item # rubocop:disable Style/CaseEquality
      when block_given?
        return true if yield(item)
      else
        return true if item
      end
    end
    false
  end

  # 6. my_none? Method--------------------------------

  def my_none?(param = nil, &prc)
    !my_any?(param, &prc)
  end

  # 7. my_count Method--------------------------------

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

  # 8. my_map Method--------------------------------

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    arr = []
    to_a.my_each { |item| arr << (proc.nil? ? yield(item) : proc.call(item)) }
    arr
  end

  # 9. my_inject Method--------------------------------
  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def my_inject(param = nil, sym = nil)
    if (param && sym.nil?) && (param.is_a?(Symbol) || param.is_a?(String))
      sym = param
      param = nil
    end

    to_a.my_each do |item|
      param = if !block_given? && sym
                param ? param.send(sym, item) : item
              else
                param ? yield(param, item) : item
              end
    end

    param
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

# 10. multiply_els Method--------------------------------

def multiply_els(arr)
  arr.my_inject(1, '*')
end
