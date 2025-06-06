require_relative 'common'

def setup_vim
  clone_vundle
  install_vim_bundles
end

def clone_vundle
  if File.exist?('vim/bundle/Vundle.vim/.git')
    LOGGER.info 'Vundle already installed'.green
  else
    not(system 'git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim') && 'Could not clone Vundle'
  end
end

def install_vim_bundles
  run_vim = 'vim +PluginInstall! +qall'
  if @update_vundle
    LOGGER.info  'Updating Vim Bundles'.blue
    not(system run_vim) && 'Error installing bundles'
  else
    LOGGER.info 'Installing Vim Bundles'.blue
    not(system run_vim.gsub('!', '')) && 'Error installing bundles'
  end
end
