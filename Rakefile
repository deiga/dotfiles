require 'rake'
require 'erb'
require 'psych'
$LOAD_PATH << '.'
Dir['lib/*.rb'].each { |lib| require lib }

# TODO: Refactor tasks to dynamically call methods

# List of files and folders to exclude from linking
EXCLUDE_FILES_FROM_COMMON = %w(Rakefile README.md LICENSE TODO.md bin config ssh tmp lib).freeze

# Shorthand for darwin platform
OSX = RUBY_PLATFORM.downcase.include?('darwin')
MAC_OS_VERSION = `defaults read loginwindow SystemVersionStampAsString`.chomp

SUBTREE_CONFIG = [
  { name: 'irssi-colors-solarized', path: 'config/irssi-colors-solarized', git: 'https://github.com/huyz/irssi-colors-solarized'},
  { name: 'irssi-trackbar', path: 'config/irssi-trackbar', git: 'https://github.com/mjholtkamp/irssi-trackbar.git'},
  { name: 'solarized', git: 'https://github.com/altercation/solarized.git', path: 'config/solarized'},
  { name: 'autohosts', git: 'https://github.com/angela-d/autohosts', path: 'config/autohosts'},
  { name: 'tpm', git: 'https://github.com/tmux-plugins/tpm', path: 'tmux/plugins/tpm'},
]

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task '' => :install

namespace :update do
  desc 'Update vundle'
  task :vundle do
    @update_vundle = true
    Rake::Task['install:vim'].invoke
  end

  desc 'Update Homebrew'
  task :brew do
    if OSX
      LOGGER.info "\nUpdate brew".blue
      system %(brew upgrade && brew cask upgrade && brew cleanup)
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
    # system %(npm update 2>/dev/null)
    # system %(npm -g install npm@latest 2>/dev/null)
    # system %(bin/npm-upgrade)
  end

  desc 'Update subtrees'
  task :subtree  do
    LOGGER.info "\nUpdate subtrees".blue
    SUBTREE_CONFIG.each do |subtree|
      update_subtree(subtree[:name], subtree[:path])
    end
  end
  task submodule: :subtree

  desc 'Update all'
  task all: %i(vundle node brew gems submodule antidote) do
  end

  task antibody: :subtree

  task :antidote do
    update_antidote
  end

  task completions: "install:completions"
end

namespace :install do
  desc "Delete and recreate symbolic links and generated files in #{ENV['HOME']}"
  task :force do
  end
  task :antidote do
    install_shell_plugin_manager
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
  end

  desc "Run macOS configs"
  task :macos do
    LOGGER.info "\Installing macOS config".blue
    system './config/.macos' if OSX
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

  desc 'Setup version managers'
  task :version_managers do
    LOGGER.info "Installing version managers".blue
    setup_asdf
  end

  desc 'Install xcode-select'
  task :'xcode-select' do
    system 'osascript lib/install_xcode_select.applescript' if OSX
  end

  desc 'Set up login items'
  task :loginitems do
    LOGGER.info "\nSetting up login items".blue
    system %(brew install OJFord/formulae/loginitems)
    system %(zsh -c 'loginitems -a Karabiner-Elements -s false')
    system %(zsh -c 'loginitems -a Amethyst')
    system %(zsh -c 'loginitems -a "Alfred 5"')
  end

  desc 'Symlink outside files'
  task :symlink do
    dropbox_ssh_keys_path = File.join(ENV['HOME'], '/', 'Dropbox', 'Avaimet', 'ssh', 'keys')
    ssh_keys_path = File.join(ENV['HOME'], '/', 'dotfiles', 'ssh', 'keys')
    until Dir.exist?(dropbox_ssh_keys_path) do
      LOGGER.info "Waiting for #{dropbox_ssh_keys_path} to exist".yellow
      sleep 15
    end
    install_dotfile(dropbox_ssh_keys_path, ssh_keys_path)
  end

  desc 'Install subtrees'
  task :subtree  do
    LOGGER.info "\Installing subtrees".blue
    SUBTREE_CONFIG.each do |subtree|
      install_subtree(subtree[:name], subtree[:git], subtree[:path])
    end
  end

  task submodule: :subtree

  task :krew do
    LOGGER.info "\Installing kubectl plugin manager Krew".blue
    install_krew
  end

  task :autohosts do
    setup_autohosts
  end

  task :completions do
    install_zsh_completions
  end

  desc 'Install all'
  task all: %w[
    xcode-select
    subtree
    common
    macos
    packages
    submodule
    zsh
    vim
    bin
    ssh
    version_managers
    symlink
    loginitems
    autohosts
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
  system %(sudo xcodebuild -license accept)
  system %(open -a 1Password')
  system %(open -a Dropbox)
  system %(open -a Evernote)
  system %(open -a Arc)
  system %(python -m pip install --upgrade pip setuptools wheel)
end

def restart_quicklook
  system %(qlmanage -r)
end

def install_homebrew
  require 'English'
  `which brew`
  unless $CHILD_STATUS.success?
    run_homebrew_install
    LOGGER.info "Homebrew installed. Please run the `eval` command from the instructions to source brew".green
    exit
  end
end

def run_homebrew_install
  LOGGER.info "\n======================================================".blue
  LOGGER.info 'Installing Homebrew, the OSX package manager...         '.blue
  LOGGER.info 'If it\'s already installed, this will do nothing.       '.blue
  LOGGER.info '========================================================'.blue
  system '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
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
  ensure_ssh_keys_permissions
end

def move_keys
  ssh_keys = Dir[File.join(ENV['HOME'], '.ssh', '*_rsa*')]
  mv(ssh_keys, File.join(Dir.pwd, 'ssh', 'keys'))
end

def switch_to_zsh
  if `ps -p #{Process.ppid}` =~ /zsh/
    LOGGER.info 'Already using ZSH'.green
  else
    print 'switch to zsh? (recommended) [ynq] '
    case $stdin.gets.chomp
    when 'y'
      LOGGER.info 'switching to zsh'.blue
      system %(echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells)
      system %(chsh -s $(brew --prefix)/bin/zsh)
    when 'q'
      exit
    else
      LOGGER.info 'skipping zsh'.blue
    end
  end
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

def install_shell_plugin_manager
  unless File.join(ENV['HOME'], '.antidote')
    LOGGER.info 'Installing antidote'.blue
    system 'git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote'
  else
    LOGGER.info 'Updating antidote'.blue
    system 'git -C ${ZDOTDIR:-~}/.antidote pull origin'
  end
  update_antidote
end

def install_packages
  LOGGER.info 'Installing packages'.blue
  if OSX
    system 'brew bundle --file=config/Brewfile'
    system '$(brew --prefix)/opt/fzf/install --no-bash --no-fish --no-update-rc --key-bindings --completion'
    install_shell_plugin_manager
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

def setup_asdf
  system 'asdf-bundle'
end

def ensure_ssh_keys_permissions
  system %(zsh -c 'setopt extendedglob; chmod 0700 ssh/keys/^*.pub')
end

def update_gems
  system %{zsh -lc 'gem update --system; gem update'}
end


def install_krew
  system %(
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
    tar zxvf krew.tar.gz &&
    KREW=./krew-"${OS}_${ARCH}" &&
    "$KREW" install krew
  )
end

def install_zsh_completions
  mkdir_p %w(zsh/Completion/)
  system %(poetry completions zsh > ~/.zsh/Completion/_poetry)
  system %(kubectl completion zsh > ~/.zsh/Completion/_kubectl)
  system %(helm completion zsh > ~/.zsh/Completion/_helm)
  system %(op completion zsh > ~/.zsh/Completion/_op)
  system %(npm completion > ~/.zsh/Completion/_npm)
  system %(register-python-argcomplete pipx > ~/.zsh/Completion/_pipx)
end

def update_antidote
  system %(zsh -c 'source ${ZDOTDIR:-~}/.antidote/antidote.zsh; antidote update; antidote bundle <$HOME/.zsh/plugins/plugins.txt >$HOME/.zsh/plugins.zsh')
end

def setup_autohosts
  system %(cd config/autohosts && sudo ./autohosts)
end
