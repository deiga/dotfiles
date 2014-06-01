require 'rake'
require 'erb'
require 'psych'
$LOAD_PATH << '.'
Dir['lib/*.rb'].each { |lib| require lib }

# TODO Refactor tasks to dynamically call methods

EXCLUDE_COMMON = %w[Rakefile README.md LICENSE TODO.md KeyRemap4MacBook bin box config ssh powerline tmp lib]

# Shorthand for darwin platform
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
    LOGGER.info "\nUpdating powerline".blue
    update_python
    update_powerline
  end

  desc "Update Homebrew"
  task :brew do
      if OSX
          LOGGER.info "\nUpdate brew".blue
          system %Q{brew update}
          system %Q{brew upgrade}
      end
  end

  desc "Update Ruby Gems"
  task :gems do
      LOGGER.info "\nUpdate gems".blue
      update_gems
  end

  desc "Update Node"
  task :node do
      LOGGER.info "\nUpdate node".blue
      system %Q{npm update 2>/dev/null}
      system %Q{npm update -g 2>/dev/null}
  end

  desc "Update submodules"
  task :submodule do
      LOGGER.info "\nUpdate submodules".blue
      system %Q{git submodule foreach git pull origin master 2>/dev/null}
  end

  desc "Updated rbenv"
  task :rbenv do
      update_rbenv
  end

 desc "Update all"
  task :all => [:vundle, :powerline, :node, :brew, :gems, :submodule, :rbenv] do
  end
end

namespace :install do
  desc "Delete and recreate symbolic links and generated files in #{ENV['HOME']}"
  task :force do
  end

  desc "Install common used gems"
  task :gems do
      LOGGER.info "\nInstall gems".blue
      system %Q{zsh -c 'gem install gem-ctags bundler rake git-up compass gem-browse httparty pry-plus;' }
  end

  task :node do
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
    install_omz_plugins
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
    install_keybindings
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

  desc "Install ruby"
  task :ruby => %w{ packages} do
      install_ruby
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
                  zsh
                  gems
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
task :install => ['install:all']

desc "Update everything"
task :update => ['update:all']

task :default => :install

def install_homebrew
  rval = %x{which brew}
  unless $?.success?
    LOGGER.info "\n======================================================".blue
    LOGGER.info "Installing Homebrew, the OSX package manager...If it's".blue
    LOGGER.info "already installed, this will do nothing.".blue
    LOGGER.info "======================================================".blue
    system %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
  end
end

def install_common_dotfiles
    files = Rake::FileList["*"].exclude("*.log").exclude("*~") - EXCLUDE_COMMON
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
    LOGGER.info "~/.ssh already linked".green
  else
    mv(Dir[File.join(ENV['HOME'], '.ssh','*')], File.join(Dir.pwd, 'ssh'))
    install_dotfile(Dir['ssh'][0], File.join(ENV['HOME'], '.ssh'))
  end
end

def move_keys
  ssh_keys = Dir[File.join(ENV['HOME'], '.ssh', '*_rsa*')]
  mv(ssh_keys, File.join(Dir.pwd, 'ssh', 'keys'))
end

def install_kr4mb
  kr4mb_file = Dir['KeyRemap4MacBook/*'][0]
  target = File.join(ENV['HOME'],'Library/Application Support', kr4mb_file)
  mkdir_p(File.join(ENV['HOME'],'Library/Application Support'))
  install_dotfile(kr4mb_file, target)
end

def switch_to_zsh
  if `ps -p #{Process::ppid}` =~ /zsh/
    LOGGER.info "Already using ZSH".green
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      LOGGER.info "switching to zsh".blue
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      LOGGER.info "skipping zsh".blue
    end
  end
end

def install_submodules
    LOGGER.info "\nInstalling submodules".blue
    system %Q{git submodule update --init --recursive}
end

def install_imagesnap
    LOGGER.info "\nInstalling imagesnap".blue
    system %Q{brew install imagesnap 2>/dev/null}
    mkdir_p(File.join(ENV['HOME'],'.gitshots'))
end

def install_slate
    LOGGER.info "\nInstalling slate".blue
    system %Q{cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz}
end

def install_launch_agents
    LOGGER.info "\nInstalling LaunchAgents".blue
    cp_r('config/launchAgents/.', File.join(ENV['HOME'], 'Library', 'LaunchAgents'))
    Dir.entries('config/launchAgents').each do |file|
        if !File.directory? file
            system %Q{launchctl load #{File.join(ENV['HOME'], 'Library', 'LaunchAgents', file)}}
        end
    end
end

def install_node
    LOGGER.info "\nInstall node, npm, nvm".blue
    OSX ? system('brew install nvm') : install_nvm
    system 'nvm install 0.10'
    system 'nvm alias default 0.10'
    system 'curl https://npmjs.org/install.sh | sh'
    install_node_packages
end

def install_node_packages
  packages = Psych.load_file('config/Nodefile')
  local = packages['local'] || []
  global = packages['global'] || []
  system %Q{npm install -g #{global.join(' ')}} unless global.empty?
  system %Q{npm install #{local.join(' ')}} unless local.empty?
end

def install_nvm
    nvm_dir = File.join(ENV['HOME'], '.nvm')
    if File.exist?(nvm_dir)
        LOGGER.info "=> NVM is already installed in #{nvm_dir}, trying to update".blue
        system %{cd #{nvm_dir}; git pull}
    else
        system %{git clone https://github.com/creationix/nvm.git #{nvm_dir}}
    end
end

def install_packages
    if OSX
        system %{brew install hub git-flow-avh}
        system %{brew install ctags coreutils git readline wget zsh vim autojump til zsh-completions ssh-copy-id 2>/dev/null}.blue

        system %{brew tap phinze/homebrew-cask && brew install brew-cask 2>/dev/null}
        system %{brew tap homebrew-science 2>/dev/null}
    else
        mkdir_p %w[~/local/bin ~/local/build]
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
        # credential
        system %{cd ~/local/build; curl -s -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain; chmod u+x git-credential-osxkeychain; mv git-credential-osxkeychain "$(dirname $(which hub))/"}
        # bzip2
        system %{cd ~/local/build; wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz; tar -zxf bzip-1.0.6.tar.gz; cd bzip2-1.0.6; make -j 3 && make install PREFIX=$HOME/local}
    end
end

def install_omz_plugins
    omz_plugins = Dir['config/oh-my-zsh/*']
    omz_plugins.each do |plugin|
        install_dotfile(plugin, File.join(ENV['HOME'], '.oh-my-zsh', 'custom', 'plugins', plugin.split('/')[-1]))
    end
end

def install_keybindings
    bindings_file = Dir['config/DefaultKeyBinding.dict'][0]
    mkdir_p(File.join(ENV['HOME'],'Library', 'KeyBindings'))
    install_dotfile(bindings_file, File.join(ENV['HOME'], 'Library', 'KeyBindings', bindings_file.split('/')[-1]))
end
