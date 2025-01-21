return {
  -- Tokyonight theme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Load this before other plugins
    config = function()
      -- Set Tokyonight as the colorscheme
      -- vim.cmd("colorscheme elford")
    end,
  },

  -- Dracula theme
  {
    "Mofiqul/dracula.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Load this before other plugins
    -- Optional: Set Dracula as the colorscheme
    -- Uncomment this block if you want Dracula
    --[[ config = function()
      vim.cmd("colorscheme dracula")
    end, ]]
  },
}
