# test.rb
require 'pry'

class A
  def hello() puts "hello world!" end
end

a = A.new

# set x to 10
x = 10

# start a REPL session
binding.pry

# program resumes here (after pry session)
puts "program resumes here. Value of x is: #{x}."
