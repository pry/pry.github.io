pry(main)> require 'grit'
=> true
pry(main)> cd Grit
pry(Grit):1> ls -M Blame
[:lines, :load_blame, :process_raw_blame]
pry(Grit):1> show-method Blame#load_blame

From: /Users/john/.rvm/gems/ruby-1.9.2-p180/gems/grit-2.4.1/lib/grit/blame.rb @ line 15:
Number of lines: 4

def load_blame
  output = @repo.git.blame({'p' => true}, @commit, '--', @file)
  process_raw_blame(output)
end
pry(Grit):1>
