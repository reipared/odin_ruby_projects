def merge_sort(array)
  if array.length <= 1
    return array
  end

  array_size = array.length
  middle = (array.length / 2).round

  left_side = array[0..middle]
  right_side = array[middle..array_size]

  sorted_left = merge_sort(left_side)
  sorted_right = merge_sort(right_side)

  merge(sorted_left, sorted_right)
end

def merge(sorted_left, sorted_right, merged_array = [])
  until sorted_left.empty? && sorted_right.empty?
    if sorted_left.empty?
      return merged_array + sorted_right
    elsif sorted_right.empty?
      return merged_array + sorted_left
    else
      # If the left is bigger than the right, we will shift the first element and push it to the array
      # If the right is bigger, we will shift that element and push it to the array until one is empty
      sorted_left[0] < sorted_right[0] ? merged_array << sorted_left.shift : merged_array << sorted_right.shift
    end
  end
  merged_array
end

merge_sort([6, 2, 5, 1, 32, 4])
