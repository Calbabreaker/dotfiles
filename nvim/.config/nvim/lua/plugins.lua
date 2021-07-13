-- automatically get packer (plugin manager)
local install_path = DATA_PATH.."/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup(function()
  use "wbthomason/packer.nvim" -- packer plugin stuff

  use "mhinz/vim-startify" -- start menu
  use "tpope/vim-surround" -- easily edit (), "", etc
  use "christoomey/vim-sort-motion" -- sorts lines
  use "sainnhe/sonokai" -- color theme
  use "svermeulen/vim-yoink" -- clipboard history
  use "tpope/vim-commentary" -- toggle comments
  use "vim-scripts/replacewithregister" -- replace motion with clipboard

  -- text object e for entire file
  use {"kana/vim-textobj-entire", requires = {"kana/vim-textobj-user"}}
  -- text object i for indents
  use {"kana/vim-textobj-indent", requires = {"kana/vim-textobj-user"}}
  -- text object , for function parameters
  use {"sgur/vim-textobj-parameter", requires ={"kana/vim-textobj-user"}}
end)
