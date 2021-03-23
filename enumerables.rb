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
end
