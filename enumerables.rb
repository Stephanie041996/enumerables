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

  def my_all?
    return to_enum unless block_given?
    my_each {|el| return false unless yield el}
    return true
  end

  def my_any?
    return to enum unless block_given?
    my_each {|el| return true if yield el}
    return false
    end
end


def is_match?(val, condition)
  case condition
    when Regex
      val ~= condition
    when Class
      val.is_a Class
    else
      val == condition
  end
end


