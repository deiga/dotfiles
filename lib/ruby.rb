require_relative 'common'

def install_rbenv
  if OSX
    system 'brew install rbenv ruby-build rbenv-readline'
    system 'export RBENV_ROOT=/usr/local/var/rbenv'
  else
    mkdir_p(File.join(ENV['HOME'], '.rbenv'))
    system 'git clone https://github.com/sstephenson/rbenv.git ~/.rbenv'
    mkdir_p(PLUGINS)
    system 'git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build'
  end
end

def install_rbenv_plugins
  plugins = File.join(ENV['RBENV_ROOT'], 'plugins') unless ENV['RBENV_ROOT'].nil?
  mkdir_p(plugins)
  Dir.chdir(plugins) do
    system 'git clone git://github.com/tpope/rbenv-communal-gems.git'
    system 'git clone https://github.com/ianheggie/rbenv-binstubs.git'
    system 'git clone git://github.com/tpope/rbenv-ctags.git'
    system 'git clone https://github.com/sstephenson/rbenv-default-gems.git'
    system 'git clone https://github.com/sstephenson/rbenv-gem-rehash.git'
    system 'git clone https://github.com/rkh/rbenv-update.git'
    system 'git clone https://github.com/rkh/rbenv-whatis.git'
    system 'git clone https://github.com/rkh/rbenv-use.git'
    system 'git clone https://github.com/sstephenson/rbenv-vars.git'
  end
end

def link_default_gems
  install_dotfile(Dir['config/default-gems'][0], File.join(ENV['RBENV_ROOT'], 'default-gems'))
end

def install_ruby
  install_rbenv
  install_rbenv_plugins
  link_default_gems
  system %{zsh -lc 'rbenv install 2.4.0'}
  system %{zsh -lc 'rbenv use 2.4 --global'}
  system %{zsh -lc 'rbenv rehash'}
end

def update_rbenv
  system 'rbenv update'
end

def update_gems
  system %{zsh -lc 'gem update --system; gem update'}
end
