return {
  -- Define the status line plugin configuration

  -- Load the lualine.nvim plugin for creating a customizable status line
  'nvim-lualine/lualine.nvim',
  
  dependencies = {
    -- Load plugins required for lualine:
    -- Adds fancy icons to the status line
    'nvim-tree/nvim-web-devicons', 

    -- Displays LSP (Language Server Protocol) loading progress in the status line
    'linrongbin16/lsp-progress.nvim', 
  },
  
  opts = {
    options = {
      -- Set the visual theme for the status line.
      -- Themes like "catppuccin" make the status line visually match your colorscheme.
      -- More themes are available at the mentioned URL.
      theme = "catppuccin", -- Options: "auto", "tokyonight", "catppuccin", "codedark", "nord"
    },
    
    sections = {
      -- Define what is displayed in the different sections of the status line

      lualine_a = {
        -- Add buffers section (e.g., show open tabs/buffers)
        {
          'buffers',
        },
      },

      lualine_c = {
        {
          -- Customize the filename display to show the parent folder and filename
          'filename',
          file_status = true,      -- Show if the file is modified or readonly
          newfile_status = true,  -- Show if the file is newly created but not yet saved
          path = 4,               -- Display parent folder and filename (path style: 4)
          symbols = {
            modified = '[+]',     -- Mark file as modified with [+]
            readonly = '[-]',     -- Mark file as readonly with [-]
          }
        },
      },

      lualine_d = {
        -- Add the current Git branch to the status line
        {'git branch'},
      },

      lualine_e = {
        -- Add Git diff information (added, modified, removed changes) to the status line
        {'diff'},
      },
    }
  }
}
