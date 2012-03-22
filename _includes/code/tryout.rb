pry(main)> cd FileUtils
pry(Pathname):1> show-method rm

From: /opt/ruby/lib/ruby/1.9.1/fileutils.rb @ line 556:
Number of lines: 10
Owner: FileUtils

def rm(list, options = {})
  fu_check_options options, OPT_TABLE['rm']
  list = fu_list(list)
  fu_output_message "rm#{options[:force] ? ' -f' : ''} #{list.join ' '}" if options[:verbose]
  return if options[:noop]

  list.each do |path|
    remove_file path, options[:force]
  end
end
pry(Pathname):2>
