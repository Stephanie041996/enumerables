module Enumerable
  def my_each
    return to_enum unless block_given?

    for ele in self
      yield ele
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    my_each do |ele|
      yield ele, i
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_arr = []

    my_each { |ele| new_arr << ele if yield ele }
    new_arr
  end

  def my_all?(para = nil)
    if block_given?
      my_each { |ele| return false unless yield ele }
    elsif para
      my_each { |ele| return false unless match?(ele, para) }
    else
      my_each { |ele| return false unless ele }
    end
    true
  end

  def my_any?(para = nil)
    if block_given?
      my_each { |ele| return true if yield ele }
    elsif para
      my_each { |ele| return true if match?(ele, para) }
    else
      my_each { |ele| return true if ele }
    end
    false
  end

  def my_none?(para = nil)
    if block_given?
      my_each { |ele| return false if yield ele }
    elsif para
      my_each { |ele| return false if match?(ele, para) }
    else
      my_each { |ele| return false if ele }
    end
    true
  end

  def my_count(para = nil)
    count = 0
    if block_given?
      my_each { |ele| count += 1 if yield ele }
    elsif para
      my_each { |ele| count += 1 if match?(ele, para) }
    else
      return length
    end
    count
  end

  def my_map(proc = nil)
    new_arr = []
    if proc
      my_each { |ele| new_arr << proc.call(ele) }
    elsif block_given?
      my_each { |ele| new_arr << yield(ele) }
    else
      return to_enum unless block_given?
    end
    new_arr
  end

  def my_inject(para1 = nil, para2 = nil)
    array = to_a
    acc = para1 || array[0]
    i = para1 ? 0 : 1
    if block_given?
      (i...array.length).each { |idx| acc = yield(acc, array[idx]) }
    elsif para1 && para2
      (i...array.length).each { |idx| acc = acc.send(para2, array[idx]) }
    elsif para1
      acc = array[0]
      (1...array.length).each { |idx| acc = acc.send(para1, array[idx]) }
    else
      raise LocalJumpError
    end
    acc
  end

  private

  def match?(ele, para)
    case para
    when Regexp
      ele =~ para
    when Class
      ele.is_a?(para)
    else
      ele == para
    end
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
