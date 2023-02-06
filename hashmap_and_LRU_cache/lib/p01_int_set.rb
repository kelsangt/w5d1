class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    if num > max || num < 0
      raise Exception.new "Out of bounds"
    else 
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    if @store[num] == true
      return true 
    end
    return false 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod = num % num_buckets
    @store[mod - 1] << num
  end

  def remove(num)
    @store.each do |sub_arr|
      if sub_arr.include?(num)
        sub_arr.delete(num)
      end
    end
  end

  def include?(num)
    @store.each do |sub_arr|
      if sub_arr.include?(num)
        return true 
      end
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num-1]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    
    mod = num % num_buckets
    if !@store[mod - 1].include?(num)
      @store[mod - 1] << num
      @count += 1
    end
    
  end

  def remove(num)
    mod = num % num_buckets
    if @store[mod - 1].include?(num)
      @store[mod - 1].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store.each do |sub_arr|
      if sub_arr.include?(num)
        return true 
      end
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    if @count == num_buckets - 1
      final_arr = []

      @store.each do |sub_arr|
        sub_arr.each do |ele|
          final_arr << ele
        end
      end

      num_buckets *= 2
      @store = Array.new(num_buckets) { Array.new }
      final_arr.each do |ele|
        insert(ele)
      end
    end
  end
end
