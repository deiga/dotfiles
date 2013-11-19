require 'fileutils'

class String
  def replace_home
    self.gsub(ENV['HOME'],'~')
  end
end

def install_dotfile(file, target_file)
  if File.exist?(target_file) or File.symlink?(target_file)
    if File.identical? file, target_file
      puts green "identical #{target_file.replace_home}"
    elsif @replace_all
      replace_file(file, target_file)
    else
      print "overwrite #{target_file.replace_home}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        @replace_all = true
        replace_file(file, target_file)
      when 'y'
        replace_file(file, target_file)
      when 'q'
        exit
      else
        puts green "skipping #{target_file.replace_home}"
      end
    end
  else
    link_file(file, target_file)
  end
end

def replace_file(file, target)
  puts blue "Replacing #{file}"
  system %Q{rm -rf "#{target}"}
  link_file(file, target)
end

def link_file(file, target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
  if file =~ /.erb$/
    puts blue "generating #{target.replace_home}"
    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts blue "linking #{target.replace_home}"
    File.symlink(File.join(Dir.pwd,file), target) # system %Q{ln -s "$PWD/#{file}" "#{target}"}
  end
end

def clean_temp
  puts blue "\nCleaning tmp"
  FileUtils.rm_r(Dir['tmp/*'])
end

def colorized(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
    colorized(text, 31)
end

def blue(text)
    colorized(text, 34)
end

def green(text)
    colorized(text, 32)
end

