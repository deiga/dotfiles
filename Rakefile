require 'rake'
require 'erb'

desc "install the dotfiles"
task :install, :update_vundle do |t, args|
    update_vundle = args[:update_vundle] || false
    switch_to_zsh
    install_common_dotfiles
    install_kr4mb
    install_bin
    setup_vim(update_vundle)
end

def replace_home(path)
    path.gsub(ENV['HOME'],'~')
end

def install_dotfile(file, target_file)
    replace_all = false
    if File.exist?(target_file)
        if File.identical? file, target_file
            puts "identical #{replace_home(target_file)}"
        elsif replace_all
            replace_file(file)
        else
            print "overwrite #{replace_home(target_file)}? [ynaq] "
            case $stdin.gets.chomp
            when 'a'
                replace_all = true
                replace_file(file)
            when 'y'
                replace_file(file)
            when 'q'
                exit
            else
                puts "skipping #{replace_home(target_file)}"
            end
        end
    else
      link_file(file, target_file)
    end
end

def install_common_dotfiles
    files = Dir['*'] - %w[Rakefile README.md LICENSE TODO.md KeyRemap4MacBook bin box config]
    files.each do |file|
        install_dotfile(file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
    end
end

def install_bin
    bin_folder = Dir['bin'][0]
    install_dotfile(bin_folder, File.join(ENV['HOME'], bin_folder))
end

def install_kr4mb
    kr4mb_file = Dir['KeyRemap4MacBook/*'][0]
    install_dotfile(kr4mb_file, File.join(ENV['HOME'],'Library/Application Support', kr4mb_file))
end

def replace_file(file)
    puts "Replacing ~/.#{file}"
    system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
    link_file(file)
end

def link_file(file, target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
    if file =~ /.erb$/
        puts "generating #{replace_home(target)}"
        File.open(target, 'w') do |new_file|
            new_file.write ERB.new(File.read(file)).result(binding)
        end
    else
        puts "linking #{replace_home(target)}"
        system %Q{ln -s "$PWD/#{file}" "#{target}"}
    end
end

def setup_vim(update_bundles)
    clone_vundle
    install_vim_bundles(update_bundles)
end

def clone_vundle
    if File.exist?('vim/bundle/vundle/.git')
        puts 'Vundle already installed'
    else
        not(system %Q{git clone https://github.com/gmarik/vundle.git vim/bundle/vundle}) && 'Could not clone Vundle'
    end
end

def install_vim_bundles(update)
    run_vim = "vim +BundleInstall! +qall"
    if update
        puts 'Updating Vim Bundles'
        not(system run_vim) && 'Error installing bundles'
    else
        puts 'Installing Vim Bundles'
        not(system run_vim.gsub('!','')) && 'Error installing bundles'
    end
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
