module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    self.to_a.length.times do |i|
      yield to_a[i]
    end

    self
  end
end
