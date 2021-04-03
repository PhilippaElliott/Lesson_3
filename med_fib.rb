

def fib(first_num, second_num)
 if  first_num + second_num < 15
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(1, 1)
puts "result is #{result}"
