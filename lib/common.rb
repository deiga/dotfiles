require 'fileutils'
require 'logger'

$log = Logger.new(STDOUT)
$log.formatter = proc do |s, dt, p, msg|
    "#{msg}\n"
end

# Monkeypatching String to include coloring of output and easy insertion of HOME
class String
  def replace_home
    self.gsub(ENV['HOME'], '~')
  end

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def blue
    colorize(34)
  end

  def green
    colorize(32)
  end
end

# Method for installing a given file/folder to given location
# * Checks for exitence of target file
# * Compares equality and asks for overwrite
def install_dotfile(file, target_file)
  if File.exist?(target_file) or File.symlink?(target_file)
    if File.identical? file, target_file
      $log.info "identical #{target_file.replace_home}".green
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
        $log.info "skipping #{target_file.replace_home}".green
      end
    end
  else
    link_file(file, target_file)
  end
end

def clean_temp
  $log.info "\nCleaning tmp".blue
  FileUtils.rm_r(Dir['tmp/*'])
end

def replace_file(file, target)
  $log.info "Replacing #{file}".blue
  system %Q{rm -rf "#{target}"}
  link_file(file, target)
end

def link_file(file, target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
  if file =~ /.erb$/
    $log.info "generating #{target.replace_home}".blue
    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    $log.info "linking #{target.replace_home}".blue
    File.symlink(File.join(Dir.pwd, file), target) # system %Q{ln -s "$PWD/#{file}" "#{target}"}
  end
end
