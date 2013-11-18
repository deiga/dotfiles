require 'fileutils'

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
