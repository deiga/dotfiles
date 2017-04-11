require 'rake'
require 'erb'
require 'psych'
$LOAD_PATH << '.'
Dir['lib/*.rb'].each { |lib| require lib }

# TODO: Refactor tasks to dynamically call methods

# List of files and folders to exclude from linking
EXCLUDE_FILES_FROM_COMMON = %w(Rakefile README.md LICENSE TODO.md Karabiner bin config ssh powerline tmp lib).freeze

# Shorthand for darwin platform
OSX = RUBY_PLATFORM.downcase.include?('darwin')

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task '' => :install

namespace :update do
  desc 'Update vundle'
  task :vundle do
    @update_vundle = true
    Rake::Task['install:vim'].invoke
  end

  desc 'Update Powerline'
  task :powerline do
    LOGGER.info "\nUpdating powerline".blue
    update_python
    update_powerline
  end

  desc 'Update Homebrew'
  task :brew do
    if OSX
      LOGGER.info "\nUpdate brew".blue
      system %(brew update)
      system %(brew upgrade)
    end
  end

  desc 'Update Ruby Gems'
  task :gems do
    LOGGER.info "\nUpdate gems".blue
    update_gems
  end

  desc 'Update Node'
  task :node do
    LOGGER.info "\nUpdate node".blue
    system %(npm update 2>/dev/null)
    system %(npm -g install npm@latest 2>/dev/null)
    system %(bin/npm-upgrade)
    install_nvm
  end

  desc 'Update submodules'
  task :submodule do
    LOGGER.info "\nUpdate submodules".blue
    system %(git submodule foreach git pull origin master 2>/dev/null)
  end

  desc 'Updated rbenv'
  task :rbenv do
    update_rbenv
  end

  desc 'Update all'
  task all: %i(vundle powerline node brew gems submodule rbenv) do
  end
end

namespace :install do
  desc "Delete and recreate symbolic links and generated files in #{ENV['HOME']}"
  task :force do
  end

  task :node do
    install_node
  end

  desc 'Copy and launch LaunchAgent scripts'
  task :agents do
    install_launch_agents if OSX
  end

  desc 'Install Python'
  task python: %w(packages) do
    install_python
  end

  desc 'Switch to ZSH'
  task :zsh do
    switch_to_zsh
    install_omz_plugins
  end

  desc 'Setup submodules'
  task :submodule do
    install_submodules
  end

  desc 'Setup Karabiner profile'
  task :karabiner do
    install_karabiner if OSX
  end

  desc 'Install Vundle and execute VundleInstall'
  task :vim do
    setup_vim
  end

  desc 'Setup ~/bin'
  task :bin do
    install_bin
  end

  desc "Symlink dotfiles and folders to #{ENV['HOME']}"
  task :common do
    install_common_dotfiles
    system './config/.macos'
  end

  desc 'Setup ~/.ssh folder without overwriting currently existing files'
  task :ssh do
    install_ssh
  end

  desc 'Install Packages'
  task :packages do
    install_homebrew if OSX
    install_packages
  end

  desc 'Install powerline'
  task powerline: %w[python zsh] do
    install_powerline
  end

  desc 'Install ruby'
  task ruby: %w[packages] do
    install_ruby
  end

  desc 'Install xcode-select'
  task :'xcode-select' do
    system 'osascript lib/install_xcode_select.scpt' if OSX
  end

  desc 'Adds 4 Spaces'
  task :spaces do
    system 'osascript lib/add_spaces.scpt' if OSX
  end

  desc 'Symlink outside files'
  task :symlink do
    system %(ln -s ~/Dropbox/atom ~/.atom)
  end

  desc 'Install all'
  task all: %w[
    xcode-select
    common
    packages
    submodule
    zsh
    ruby
    vim
    karabiner
    bin
    ssh
    powerline
    node
    spaces
    symlink
  ] do
  end
end

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task install: ['install:all']

desc 'Update everything'
task update: ['update:all']

task default: :install

Rake::Task['install:packages'].enhance do
  restart_quicklook
  system %(open '/usr/local/Caskroom/lastpass/latest/LastPass Installer.app')
  system %(open -a Dropbox)
  system %(open -a Evernote)
  system %(open -a 'Google Chrome')
end

def restart_quicklook
  system %(qlmanage -r)
end

def install_homebrew
  require 'English'
  `which brew`
  run_homebrew_install unless $CHILD_STATUS.success?
end

def run_homebrew_install
  LOGGER.info "\n======================================================".blue
  LOGGER.info 'Installing Homebrew, the OSX package manager...         '.blue
  LOGGER.info 'If it\'s already installed, this will do nothing.       '.blue
  LOGGER.info '========================================================'.blue
  system 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
end

def install_common_dotfiles
  files = Rake::FileList['*'].exclude('*.log').exclude('*~') - EXCLUDE_FILES_FROM_COMMON
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
    LOGGER.info '~/.ssh already linked'.green
  else
    mv(Dir[File.join(ENV['HOME'], '.ssh', '*')], File.join(Dir.pwd, 'ssh'))
    install_dotfile(Dir['ssh'][0], File.join(ENV['HOME'], '.ssh'))
  end
end

def move_keys
  ssh_keys = Dir[File.join(ENV['HOME'], '.ssh', '*_rsa*')]
  mv(ssh_keys, File.join(Dir.pwd, 'ssh', 'keys'))
end

def install_karabiner
  link_karabiner_binary
  karabiner_file = Dir['Karabiner/*'][0]
  target = File.join(ENV['HOME'], 'Library', 'Application Support', karabiner_file)
  mkdir_p(File.dirname(target))
  install_dotfile(karabiner_file, target)
  system 'open -a Karabiner'
  system '/Applications/Karabiner.app/Contents/Library/bin/karabiner enable remap.controlL2controlL_escape'
  system '/Applications/Karabiner.app/Contents/Library/bin/karabiner enable space_cadet.left_control_to_hyper'
  system '/Applications/Karabiner.app/Contents/Library/bin/karabiner enable private.shifts_to_parens'
  system '/Applications/Karabiner.app/Contents/Library/bin/karabiner set parameter.keyoverlaidmodifier_timeout 700'
end

def link_karabiner_binary
  karabiner_binary = File.join('/', 'Applications', 'Karabiner.app', 'Contents', 'Library', 'bin', 'karabiner')
  homebrew_bin_path = File.join('/', 'usr', 'local', 'bin')
  install_dotfile(karabiner_binary, homebrew_bin_path)
end

def switch_to_zsh
  if `ps -p #{Process.ppid}` =~ /zsh/
    LOGGER.info 'Already using ZSH'.green
  else
    print 'switch to zsh? (recommended) [ynq] '
    case $stdin.gets.chomp
    when 'y'
      LOGGER.info 'switching to zsh'.blue
      system %(if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells; fi;)
      # system %(sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh)
      system %(chsh -s `which zsh`)
    when 'q'
      exit
    else
      LOGGER.info 'skipping zsh'.blue
    end
  end
end

def install_submodules
  LOGGER.info "\nInstalling submodules".blue
  system %(git submodule update --init --recursive)
end

def install_launch_agents
  LOGGER.info "\nInstalling LaunchAgents".blue
  target_dir = File.join(ENV['HOME'], 'Library', 'LaunchAgents')
  launchagents_dir = File.join('config', 'launchAgents')
  Dir.entries(launchagents_dir).each do |file|
    if !File.directory?(file) && !file.end_with?('~')
      install_dotfile(File.join(launchagents_dir, file), File.join(target_dir, file))
      system %(launchctl load #{File.join(target_dir, file)})
    end
  end
end

def install_node
  require 'English'
  LOGGER.info "\nInstall node, npm, nvm".blue
  install_nvm
  system %(command -p -v node)
  if $CHILD_STATUS.success?
    system %(zsh -lc 'nvm install node --reinstall-packages-from=node')
  else
    system %(zsh -lc 'nvm install node')
  end
  system %(zsh -lc 'nvm alias default node; nvm use default')
  system %(zsh -lc 'curl https://npmjs.org/install.sh | sh')
  install_node_packages
end

def install_node_packages
  packages = Psych.load_file('config/Nodefile')
  local = packages['local'] || []
  global = packages['global'] || []
  system %(npm install -g #{global.join(' ')}) unless global.empty?
  system %(npm install #{local.join(' ')}) unless local.empty?
end

def install_nvm
  nvm_dir = File.join(ENV['HOME'], '.nvm')
  if File.exist?(nvm_dir)
    LOGGER.info "=> NVM is already installed in #{nvm_dir}, trying to update".blue
    system %(cd #{nvm_dir} && git fetch origin)
  else
    system %(git clone https://github.com/creationix/nvm.git #{nvm_dir})
  end
  system %(cd #{nvm_dir} && git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin` && . #{nvm_dir}/nvm.sh)
end

def install_packages
  LOGGER.info 'Installing packages'.blue
  if OSX
    system 'brew bundle --file=config/Brewfile'
  else
    mkdir_p %w(~/local/bin ~/local/build)
    ENV['LD_LIBRARY_PATH'] = File.join(ENV['HOME'], 'local/lib')
    ENV['LD_RUN_PATH'] = ENV['LD_LIBRARY_PATH']
    ENV['LDFLAGS'] = '-L' + File.join(ENV['HOME'], 'local/lib')
    ENV['CPPFLAGS'] = '-I' + File.join(ENV['HOME'], 'local/include') + ' -fPIC'
    ENV['CXXFLAGS'] = ENV['CPPFLAGS']
    ENV['CFLAGS'] = ENV['CPPFLAGS']
    # hub
    system %(curl http://hub.github.com/standalone -sLo ~/local/bin/hub && chmod +x ~/local/bin/hub)
    # ctags
    system %(cd ~/local/build; wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz; tar -zxf ctags-5.8.tar.gz; cd ctags-5.8; ./configure --prefix=$HOME/local && make -j 3 && make install)
    # readline
    system %(cd ~/local/build; wget ftp://ftp.cwru.edu/pub/bash/readline-6.2.tar.gz; tar -zxf readline-6.2.tar.gz; cd readline-6.2; ./configure --prefix=$HOME/local && make -j 3 && make install)
    # zsh
    system %(cd ~/local/build; wget http://sourceforge.net/projects/zsh/files/zsh/5.0.2/zsh-5.0.2.tar.gz; tar -zxf zsh-5.0.2.tar.gz; cd zsh-5.0.2; ./configure --prefix=$HOME/local && make -j 3 && make install)
    # autojump
    system %(cd ~/local/build; git clone git://github.com/joelthelion/autojump.git; cd autojump; git pull origin; ./install.sh --local && ln -s ~/.autojump/bin/* ~/local/bin)
    # credential
    system %(cd ~/local/build; curl -s -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain; chmod u+x git-credential-osxkeychain; mv git-credential-osxkeychain "$(dirname $(which hub))/")
    # bzip2
    system %(cd ~/local/build; wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz; tar -zxf bzip-1.0.6.tar.gz; cd bzip2-1.0.6; make -j 3 && make install PREFIX=$HOME/local)
  end
end

def install_omz_plugins
  omz_plugins = Dir['config/oh-my-zsh/*']
  omz_plugins.each do |plugin|
    install_dotfile(plugin, File.join(ENV['HOME'], '.oh-my-zsh', 'custom', 'plugins', plugin.split('/')[-1]))
  end
end
