pry(main)> class Hello
pry(main)*   @x = 20
pry(main)* end
=> 20
pry(main)> cd Hello
pry(Hello):1> ls -i
=> [:@x]
pry(Hello):1> cd @x
pry(20:2)> self + 10
=> 30
pry(20:2)> cd ..
pry(Hello):1> cd ..
pry(main)> cd ..
