return {
  -- add dracula
   "Mofiqul/dracula.nvim" ,

  -- Configure LazyVim to load dracula
  config = function()
    vim.cmd("colorscheme dracula")
  end
}
