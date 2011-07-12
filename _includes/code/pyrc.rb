pry(main)> shell-mode
pry main:/home/john/ruby/projects/pry $ .cd ~
pry main:/home/john $ .emacsclient .pryrc
pry main:/home/john $ .cat .pryrc
def hello_world
  puts "hello world!"
end
pry main:/home/john $ load ".pryrc"
=> true
pry main:/home/john $ hello_world
hello world!
