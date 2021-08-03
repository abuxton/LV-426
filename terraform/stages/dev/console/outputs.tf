output "out" {
  value = [
    for i in range(1, 101) : i % 15 == 0 ? "FizzBuzz" : i % 5 == 0 ? "Buzz" : i % 3 == 0 ? "Fizz" : i
  ]
}
