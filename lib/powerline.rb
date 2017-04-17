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
  system %(zsh -lc 'PIP_REQUIRE_VIRTUALENV="" pip install -U powerline-status')
end
