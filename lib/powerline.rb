require_relative 'common'

def install_powerline
  LOGGER.info 'Installing powerline'.blue
  system 'brew install libgit2 2>/dev/null' if OSX
  update_powerline
  mkdir_p(File.join(ENV['HOME'], '.config'))
  install_dotfile(Dir['powerline'][0], File.join(ENV['HOME'], '.config', 'powerline'))
  LOGGER.info "\nYou need to add 'source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh' to your ~/.zshrc file".red
  LOGGER.info 'You need to set your terminal to use any of the installed powerline fonts'.red
end

def update_powerline
  # system 'pip install -U --user git+git://github.com/Lokaltog/powerline'
  system 'pip install -U git+git://github.com/Lokaltog/powerline'
end

def install_fonts
  LOGGER.info "\nInstalling Fonts".blue
  system 'brew install wget 2>/dev/null'
  system 'git submodule update --init --recursive config/powerline-fonts'
  system 'brew cask install font-source-code-pro'
  font_paths = Dir[File.join('config', 'powerline-fonts', '*', '*.otf')]
  cp(font_paths, File.join(ENV['HOME'], 'Library', 'Fonts'))
end
