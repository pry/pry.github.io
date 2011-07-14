pry(main)> require 'pathname'
=> true
pry(main)> cd Pathname
pry(Pathname):1> show-method unlink

From: /Users/john/.rvm/rubies/ruby-1.9.2-p180/lib/ruby/1.9.1/pathname.rb @ line 1031:
Number of lines: 7

def unlink()
  begin
    Dir.unlink @path
  rescue Errno::ENOTDIR
    File.unlink @path
  end
end
pry(Pathname):1>
