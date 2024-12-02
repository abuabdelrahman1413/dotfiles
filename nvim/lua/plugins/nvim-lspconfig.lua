-- LSP Support
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',      -- Bash
        'cssls',       -- CSS
        'html',        -- HTML
        'lua_ls',      -- Lua
        'jsonls',      -- JSON
        'pyright',     -- Python
        'yamlls',      -- YAML
      }
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'black',   -- Python formatter
        'debugpy', -- Python debugger
        'flake8',  -- Python linter
        'isort',   -- Python import sorter
        'mypy',    -- Python type checker
        'pylint',  -- Python linter
      },
    })

    vim.api.nvim_command('MasonToolsInstall')

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Define keybindings or other setup actions here
    end

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
          root_dir = function(fname)
            return require('lspconfig').util.root_pattern(
              '.git',
              'package.json',
              'pyproject.toml',
              'setup.cfg',
              'Makefile'
            )(fname) or vim.loop.cwd()
          end,
        })
      end,

      -- Special configuration for Lua
      ['lua_ls'] = function()
        lspconfig.lua_ls.setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
          root_dir = function(fname)
            return require('lspconfig').util.root_pattern(
              'init.lua',
              'main.lua',
              '?.lua',
              '?.lua'
            )(fname) or vim.loop.cwd()
          end,
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',  -- Ensure compatibility with Neovim
                path = vim.split(package.path, ';'),
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,  -- Optional; adjust as needed
              },
              telemetry = {
                enable = false,  -- Disable telemetry if desired
              },
            },
          },
        })
      end,
    })

    -- Globally configure LSP floating previews
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Use rounded borders for LSP popups
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
