return {
  -- Main LSP configuration plugin
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Management plugin for managing and installing LSPs
    { 'williamboman/mason.nvim' },
    -- Integration of mason with lspconfig for seamless setup
    { 'williamboman/mason-lspconfig.nvim' },

    -- Auto-install tools like linters, formatters, and debuggers
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Useful for displaying status updates for LSP processes
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional Lua configuration to enhance Neovim setup
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    -- Setup Mason to manage LSP servers, linters, and formatters
    require('mason').setup()

    -- Setup Mason-LSPconfig to automatically install LSPs
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',      -- Bash language server
        'cssls',       -- CSS language server
        'html',        -- HTML language server
        'lua_ls',      -- Lua language server
        'jsonls',      -- JSON language server
        'pyright',     -- Python language server
        'yamlls',      -- YAML language server
      }
    })

    -- Setup auto-installation of tools (formatters and linters)
    require('mason-tool-installer').setup({
      ensure_installed = {
        'black',   -- Python code formatter
        'debugpy', -- Python debugger
        'flake8',  -- Python linter
        'mypy',    -- Python type checker
        'pylint',  -- Python linter
      },
    })

    -- Install necessary tools defined in mason-tool-installer
    vim.api.nvim_command('MasonToolsInstall')

    -- Initialize lspconfig for setting up LSPs
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Custom function for LSP on-attach actions (e.g., key bindings)
    local lsp_attach = function(client, bufnr)
      -- Define keybindings and additional configurations here
    end

    -- Setup handlers for all LSP servers managed by Mason
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,  -- Run custom attach function
          capabilities = lsp_capabilities,  -- Capabilities to enhance autocompletion and LSP features
          root_dir = function()
            return vim.loop.cwd()  -- Use the current working directory as the root
          end,
        })
      end
    })

    -- Globally configure LSP floating previews to use rounded borders
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"  -- Set default border style to "rounded"
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
