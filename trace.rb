$prefix = "/usr/local/lib/ruby/gems/2.3.0/gems/"
File.readlines('trace.txt').select{|line|
  line =~ /File/
}.map{|line|
  line =~ /File "(.*)" line (.*?) in/
  "#{$1}:#{$2}"
}.map{|line|
  line =~ %r(.*ruby/2.3.0/gems/(.*))
  $1
}.map{|line|
  file, line_no_string = line.split(':')
  line_no = line_no_string.to_i
  path = $prefix + file
  if File.exist?(path)
    [path, line_no, File.readlines(path).slice(line_no - 2, 3)]
  else
    [path, line_no, "(file missing)"]
  end
}.each{|path, line_no, line|
  puts "#{path}:#{line_no}"
  puts line
  puts " -" * 40
}
