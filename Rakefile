require 'rake'
require 'erb'

desc "install the dotfiles"
task :install do
  switch_to_zsh
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.md LICENSE TODO.md]
  files.each do |file|
    # system %Q{mkdir -vputs "$HOME/.#{File.dirname(file)}"} if file =~ /\// # Created directries in homefolder? (DEPRECATED ?)
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  setup_vim
end

def replace_file(file)
  puts "Replacing ~/.#{file}"
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def setup_vim
  clone_vundle
  install_vim_bundles
end

def clone_vundle
  if File.exist?('vim/bundle/vundle/.git')
    puts 'Vundle already installed'
  else
    not(system %Q{git clone https://github.com/gmarik/vundle.git vim/bundle/vundle}) && 'Could not clone Vundle'
  end
end

def install_vim_bundles
  puts 'Updating Vim Bundles'
  not(system %Q{vim +BundleInstall +qall}) && 'Error installing bundles'
end


def switch_to_zsh
  if `ps -p #{Process::ppid}` =~ /zsh/
    puts "Already using ZSH"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end
