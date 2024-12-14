-- Navigate nvim and tmux windows/panels with vim bindings
return {
  -- https://github.com/christoomey/vim-tmux-navigator
  'christoomey/vim-tmux-navigator',
  vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
  vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>"),
  vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>"),
  vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
  -- Only load this plugin if tmux is being used
  event = function()
    if vim.fn.exists("$TMUX") == 1 then
      return "VeryLazy"
    end
  end,
}

