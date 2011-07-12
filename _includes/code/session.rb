pry(main)> a.hello
hello world!
=> nil
pry(main)> puts x
10
=> nil
pry(main)> def a.goodbye
pry(main)*   puts "goodbye cruel world!"
pry(main)* end
=> nil
pry(main)> a.goodbye
goodbye cruel world!
=> nil
pry(main)> x = "changed"
pry(main)> exit

# OUTPUT: program resumes here Value of x is: changed.
