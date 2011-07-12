pry(main)> a.hello
hello world!
=> nil
pry(main)> def a.goodbye
pry(main)*   puts "goodbye cruel world!"
pry(main)* end
=> nil
pry(main)> a.goodbye
goodbye cruel world!
=> nil
pry(main)> exit

# program resumes here.
