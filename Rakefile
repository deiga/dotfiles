require 'rake'
require 'erb'
require 'fileutils'

# TODO Refactor tasks to dynamically call methods

EXCLUDE_COMMON = %w[Rakefile README.md LICENSE TODO.md KeyRemap4MacBook bin box config ssh powerline tmp]
OSX= RUBY_PLATFORM.downcase.include?('darwin')

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task '' => :install

namespace :update do
  desc "Update vundle"
  task :vundle do
    @update_vundle = true
    Rake::Task['install:vim'].invoke
  end

  desc "Update Powerline"
  task :powerline do
    puts blue "\nUpdating powerline"
    update_python
    update_powerline 
  end

  desc "Update Homebrew"
  task :brew do
      if OSX
          puts blue "\nUpdate brew"
          system %Q{brew update}
          system %Q{brew upgrade}
      end
  end

  desc "Update Ruby Gems"
  task :gems do
      puts blue "\nUpdate gems"
      system %Q{zsh -c 'rvm gemset use global; gem update --system; gem update'}
  end

  desc "Update Node"
  task :node do
      puts blue "\nUpdate node"
      system %Q{npm update 2>/dev/null}
      system %Q{npm update -g 2>/dev/null}
  end

  desc "Update submodules"
  task :submodule do
      puts blue "\nUpdate submodules"
      system %Q{git submodule foreach git pull origin master 2>/dev/null}
  end

  desc "Update all"
  task :all => [:vundle, :powerline, :node, :brew, :gems, :submodule] do
  end
end

namespace :install do
  desc "Delete and recreate symbolic links and generated files in #{ENV['HOME']}"
  task :force do
  end

  desc "Install common used gems"
  task :gems => %w{zsh rvm} do
      puts blue "\nInstall gems"
      system %Q{zsh -c 'rvm gemset use global; gem install gem-ctags bundler rake git-up rubygems-bundler compass gem-browse httparty ruby-lint pry-plus;' }
  end

  task :node => %w{ packages} do
      install_node
  end

  desc "Copy and launch LaunchAgent scripts"
  task :agents do
    install_launch_agents if OSX
  end

  desc "Install Python"
  task :python => %w{ packages} do
      install_python
  end

  desc "Setup imagesnap to take pictrues of commits"
  task :imagesnap do
      install_imagesnap if OSX
    end

  desc "Install Slate.app"
  task :slate do
      install_slate if OSX
    end

  desc "Switch to ZSH"
  task :zsh do
    switch_to_zsh
  end

  desc "Setup submodules"
  task :submodule do
      install_submodules
    end

  desc "Setup KeyRemap4MacBook profile"
  task :kr4mb do
    install_kr4mb if OSX
  end

  desc "Install Vundle and execute VundleInstall"
  task :vim do
    setup_vim
  end

  desc "Setup ~/bin"
  task :bin do
    install_bin
  end

  desc "Symlink dotfiles and folders to #{ENV['HOME']}"
  task :common do
    install_common_dotfiles
  end

  desc "Setup ~/.ssh folder without overwriting currently existing files"
  task :ssh do
    install_ssh
  end

  desc "Install Packages"
  task :packages do
    install_homebrew if OSX
    install_packages
  end

  desc "Install powerline (installs zsh and powerline-fonts)"
  task :powerline => %w{ python zsh} do
    install_powerline 
  end

  desc "Install rvm"
  task :rvm => %w{ packages} do
      install_rvm
  end

  desc "Install fonts"
  task :fonts do
    install_fonts if OSX
  end

  desc "Install all"
  task :all => %w{
                  submodule
                  common
                  packages
                  rvm
                  gems
                  zsh
                  vim
                  kr4mb
                  bin
                  ssh
                  fonts
                  powerline
                  imagesnap
                  node
                            } do
  end
end

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task :install => ['install:all'] do
end

desc "Update everything"
task :update => ['update:all'] do

end

task :default => :install

class String
  def replace_home
    self.gsub(ENV['HOME'],'~')
  end
end

def install_homebrew
  rval = %x{which brew}
  unless $?.success?
    puts blue "\n======================================================"
    puts blue "Installing Homebrew, the OSX package manager...If it's"
    puts blue "already installed, this will do nothing."
    puts blue "======================================================"
    system %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
  end
end

def install_python
    if OSX
        system %{brew install python --with-brewed-openssl}
    else
        system %{cd ~/local/build; wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz; tar -zxf Python-2.7.5.tgz; cd Python-2.7.5; ./configure --prefix=$HOME/local && make -j 3 && make install}
        system %{cd ~/local/build; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python }
        system %{cd ~/local/build; curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python }
        system %{cd ~/local/build; git clone git://github.com/libgit2/libgit2.git -b master; cd libgit2; git pull origin; mkdir build; cd build; cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/local && cmake --build . --target install}
    end
    update_python
end

def update_python
    system %{pip install -U setuptools pip}
    system %{pip install -U mercurial psutil}
    system %{LIBGIT2="$HOME/local" LDFLAGS="-Wl,-rpath='$LIBGIT2/lib',--enable-new-dtags $LDFLAGS" pip install -U pygit2} unless OSX
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

def install_common_dotfiles
  files = Dir['*'] - EXCLUDE_COMMON - Dir['*~']
  files.each do |file|
    install_dotfile(file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
  end
end

def install_bin
  bin_folder = Dir['bin'][0]
  install_dotfile(bin_folder, File.join(ENV['HOME'], bin_folder))
end

def install_ssh
  move_keys

  if File.symlink?(File.join(ENV['HOME'], '.ssh'))
    puts green "~/.ssh already linked"
  else
    FileUtils.mv(Dir[File.join(ENV['HOME'], '.ssh','*')], File.join(Dir.pwd, 'ssh'))
    install_dotfile(Dir['ssh'][0], File.join(ENV['HOME'], '.ssh'))
  end
end

def move_keys
  ssh_keys = Dir[File.join(ENV['HOME'], '.ssh', '*_rsa*')]
  FileUtils.mv(ssh_keys, File.join(Dir.pwd, 'ssh', 'keys'))
end

def install_kr4mb
  kr4mb_file = Dir['KeyRemap4MacBook/*'][0]
  target = File.join(ENV['HOME'],'Library/Application Support', kr4mb_file)
  FileUtils.mkdir_p(File.join(ENV['HOME'],'Library/Application Support'))
  install_dotfile(kr4mb_file, target)
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

def setup_vim
  clone_vundle
  install_vim_bundles
end

def clone_vundle
  if File.exist?('vim/bundle/vundle/.git')
    puts green 'Vundle already installed'
  else
    not(system %Q{git clone https://github.com/gmarik/vundle.git vim/bundle/vundle}) && 'Could not clone Vundle'
  end
end

def install_vim_bundles
  run_vim = "vim +BundleInstall! +qall"
  if @update_vundle
    puts  blue 'Updating Vim Bundles'
    not(system run_vim) && 'Error installing bundles'
  else
    puts blue 'Installing Vim Bundles'
    not(system run_vim.gsub('!','')) && 'Error installing bundles'
  end
end


def switch_to_zsh
  if `ps -p #{Process::ppid}` =~ /zsh/
    puts green "Already using ZSH"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts blue "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts blue "skipping zsh"
    end
  end
end

def install_powerline
  puts blue "Installing powerline"
  system %{brew install libgit2 2>/dev/null} if OSX
  update_powerline
  FileUtils.mkdir_p(File.join(ENV['HOME'], '.config'))
  install_dotfile(Dir['powerline'][0], File.join(ENV['HOME'], '.config', 'powerline'))
  puts red "\nYou need to add 'source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh' to your ~/.zshrc file"
  puts red "You need to set your terminal to use any of the installed powerline fonts"
end

def update_powerline
  # system %{pip install -U --user git+git://github.com/Lokaltog/powerline}
  system %{pip install -U git+git://github.com/Lokaltog/powerline}
end

def install_fonts
  puts blue "\nInstalling Fonts"
  system %{brew install wget 2>/dev/null}
  system %Q{git submodule update --init --recursive config/powerline-fonts}
  FileUtils.mkdir_p('tmp')
  %x{wget -q http://sourceforge.net/projects/sourcecodepro.adobe/files/latest/download\?source\=files -O tmp/source_code_pro_latest.zip}
  %x{unzip tmp/source_code_pro_latest.zip -d tmp/}
  font_paths = Dir['tmp/SourceCodePro*/OTF/*'] + Dir[File.join('config', 'powerline-fonts' ,'*', '*.otf')]
  FileUtils.cp(font_paths, File.join(ENV['HOME'], 'Library', 'Fonts'))
  clean_temp
end

def clean_temp
  puts blue "\nCleaning tmp"
  FileUtils.rm_r(Dir['tmp/*'])
end

def install_submodules
    puts blue "\nInstalling submodules"
    system %Q{git submodule update --init --recursive}
end

def install_imagesnap
    puts blue "\nInstalling imagesnap"
    system %Q{brew install imagesnap 2>/dev/null}
    FileUtils.mkdir_p('~/.gitshots')
end

def install_slate
    puts blue "\nInstalling slate"
    system %Q{cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz}
end

def install_launch_agents
    puts blue "\nInstalling LaunchAgents"
    FileUtils.cp_r('config/launchAgents/.', File.join(ENV['HOME'], 'Library', 'LaunchAgents'))
    Dir.entries('config/launchAgents').each do |file|
        if !File.directory? file
            system %Q{launchctl load #{File.join(ENV['HOME'], 'Library', 'LaunchAgents', file)}}
        end
    end
end

def install_rvm
    puts blue "\nInstalling RVM"
    autolibs = OSX ? 'homebrew' : 'packages'
    system %Q{curl -L https://get.rvm.io | bash -s stable --autolibs=#{autolibs} --ruby}
    system %Q{rvm autolibs homebrew} if OSX
end

def install_node
    puts blue "\nInstall node, npm, nvm"
    if OSX
        system %Q{brew install node 2>/dev/null}
        system %{rm /usr/local/bin/npm; ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm}
    else
        node_version = 'v0.10.18'
        system %{cd /tmp; wget http://nodejs.org/dist/#{node_version}/node-#{node_version}.tar.gz; tar -zxf node-#{node_version}.tar.gz; cd node-#{node_version}; ./configure --prefix=~/local/node && make -j 3 && make install;}
        system %{ln -s ~/local/node/bin/* ~/local/bin}
        system %{rm -rf /tmp/node-*}
    end
    system %Q{npm install -g nvm yo bower node-static coffee-script generator-webapp generator-angular generator-karma}
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

def install_packages
    if OSX
        system %{brew install hub git-flow-avh}
        system %{brew install ctags coreutils git readline wget zsh vim autojump blueutil zsh-completions ssh-copy-id 2>/dev/null}

        system %{brew tap phinze/homebrew-cask && brew install brew-cask 2>/dev/null}
        system %{brew tap homebrew-science 2>/dev/null}
    else
        system %{mkdir -p ~/local/bin ~/local/build}
        ENV['LD_LIBRARY_PATH']=File.join(ENV['HOME'], 'local/lib')
        ENV['LD_RUN_PATH']=ENV['LD_LIBRARY_PATH']
        ENV['LDFLAGS'] = "-L"+File.join(ENV['HOME'], 'local/lib')
        ENV['CPPFLAGS'] = "-I"+File.join(ENV['HOME'], 'local/include')+" -fPIC"
        ENV['CXXFLAGS'] = ENV['CPPFLAGS']
        ENV['CFLAGS'] = ENV['CPPFLAGS']
        # hub
        system %{curl http://hub.github.com/standalone -sLo ~/local/bin/hub && chmod +x ~/local/bin/hub}
        # gitflow-avh
        system %{wget --no-check-certificate -q  https://raw.github.com/petervanderdoes/gitflow/develop/contrib/gitflow-installer.sh && PREFIX="$HOME/local" REPO_NAME="$PREFIX/build/gitflow" bash gitflow-installer.sh install stable; rm gitflow-installer.sh}
        # ctags
        system %{cd ~/local/build; wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz; tar -zxf ctags-5.8.tar.gz; cd ctags-5.8; ./configure --prefix=$HOME/local && make -j 3 && make install}
        # readline
        system %{cd ~/local/build; wget ftp://ftp.cwru.edu/pub/bash/readline-6.2.tar.gz; tar -zxf readline-6.2.tar.gz; cd readline-6.2; ./configure --prefix=$HOME/local && make -j 3 && make install}
        # zsh
        system %{cd ~/local/build; wget http://sourceforge.net/projects/zsh/files/zsh/5.0.2/zsh-5.0.2.tar.gz; tar -zxf zsh-5.0.2.tar.gz; cd zsh-5.0.2; ./configure --prefix=$HOME/local && make -j 3 && make install}
        # autojump
        system %{cd ~/local/build; git clone git://github.com/joelthelion/autojump.git; cd autojump; git pull origin; ./install.sh --local && ln -s ~/.autojump/bin/* ~/local/bin}
        # bzip2
        system %{cd ~/local/build; wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz; tar -zxf bzip-1.0.6.tar.gz; cd bzip2-1.0.6; make -j 3 && make install PREFIX=$HOME/local}
    end
end
