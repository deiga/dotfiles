require_relative 'common'

def install_powerline
  $log.info 'Installing powerline'.blue
  system 'brew install libgit2 2>/dev/null' if OSX
  update_powerline
  FileUtils.mkdir_p(File.join(ENV['HOME'], '.config'))
  install_dotfile(Dir['powerline'][0], File.join(ENV['HOME'], '.config', 'powerline'))
  $log.info "\nYou need to add 'source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh' to your ~/.zshrc file".red
  $log.info 'You need to set your terminal to use any of the installed powerline fonts'.red
end

def update_powerline
  # system 'pip install -U --user git+git://github.com/Lokaltog/powerline'
  system 'pip install -U git+git://github.com/Lokaltog/powerline'
end

def install_fonts
  $log.info "\nInstalling Fonts".blue
  system 'brew install wget 2>/dev/null'
  system 'git submodule update --init --recursive config/powerline-fonts'
  FileUtils.mkdir_p('tmp')
  %x{wget -q http://sourceforge.net/projects/sourcecodepro.adobe/files/latest/download\?source\=files -O tmp/source_code_pro_latest.zip}
  %x{unzip tmp/source_code_pro_latest.zip -d tmp/}
  font_paths = Dir['tmp/SourceCodePro*/OTF/*'] + Dir[File.join('config', 'powerline-fonts', '*', '*.otf')]
  FileUtils.cp(font_paths, File.join(ENV['HOME'], 'Library', 'Fonts'))
  clean_temp
end
