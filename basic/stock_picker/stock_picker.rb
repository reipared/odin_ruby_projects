def stock_picker(prices)
  min_price = prices[0]
  min_index = 0

  profit = 0
  days = [0, 0]

  prices.each_with_index do |p, i|
    if p < min_price
      min_price = p
      min_index = i
      next
    end

    if p - min_price > profit
      profit = p - min_price
      days = [min_index, i]
    end
  end

  days
end

array = [17, 3, 6, 9, 15, 8, 5, 1, 10]

p stock_picker(array)
# => [1, 4]