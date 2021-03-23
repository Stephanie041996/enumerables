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
    my_each do |el|
      yield el, i
      i += 1
    end
  end

  def my_select
    new_arr = []
    return to_enum unless block_given?

    my_each do |el|
      new_arr << el if yeild el
    end
    new_arr
  end

  def my_all?(para = nil)
    if block_given?
      my_each do |el|
        return false unless yield el
      end
    elsif para
      my_each do |el|
        return false unless match?(el, para)
      end
    else
      my_each do |el|
        return false unless el
      end
    end
    true
  end

  def my_any?(para = nil)
    if block_given?
      my_each do |el|
        return true if yield el
      end
    elsif para
      my_each do |ele|
        return true if match?(ele, para)
      end
    else
      my_each do |el|
        return true if el
      end
    end
    false
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
