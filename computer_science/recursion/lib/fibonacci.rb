# Iteration
def fibonacci(n)
  first_num = 0
  second_num = 1
  fibonacci_sequence = []
  while second_num < n
    first_num, second_num = second_num, first_num + second_num
    fibonacci_sequence << second_num
  end
  fibonacci_sequence
end

# One liner found in Stack Overflow using Hash
# FIB = Hash.new {|hash, key| hash[key] = key < 2 ? key : hash[key-1] + hash[key-2] }
FIBONACCI = Hash.new { |h, k| h[k] = k < 2 ? k : h[k - 1] + h[k - 2] }

# Recursion
def fibonacci_seq(num)
  return [0, 1] if num <= 2

  seq = fibonacci_seq(num - 1)
  seq << seq[-2] + seq[1]
  seq
end
