module Enumerable
  def my_each
    if block_given?
      for i in self
        yield i
      end
    end
    to_enum
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
    new_arr = []
    return to_enum unless block_given?

    my_each do |ele|
      new_arr << ele if yield ele
    end
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
    if block_given?
      my_each { |ele| count += 1 if yield ele }
    elsif para
      my_each { |ele| count += 1 if match?(ele, para) }
    else
      length
    end
    count
  end

  def my_map
    new_arr = []
    return to_enum unless block_given?

    my_each do |ele|
      new_arr << yeild(ele)
    end
    new_arr
  end

  def my_inject(para1 = nil, para2 = nil)
    array = self.to_a
    if block_given?
      acc = para1 ? para1 : array[0]
      i = para1 ? 0 : 1
      (i...array.length).each do |idx|
        acc = yield(acc , array[ idx])
      end
    elsif para1 && para2
      acc = para1 ? para1 : array[0]
      i = para1 ? 0 : 1
      (i...array.length).each do |idx|
         acc = acc.send(para2,array[idx])
      end
    elsif para1
      acc = array[0]
      (1...array.length).each do |idx|
        acc = acc.send(para1,array[idx])
      end
    else
      raise LocalJump
    end
    acc
  end

  # pattern matching function
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
  # module end
end
