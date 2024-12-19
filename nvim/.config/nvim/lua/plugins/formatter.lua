-- Formatter configuration using Conform
return {
  -- Plugin URL: https://github.com/stevearc/conform.nvim
  -- Conform is a Neovim plugin designed for managing and running formatters for different filetypes.
  'stevearc/conform.nvim',

  -- The plugin will be loaded when a file is saved ("BufWritePre" event).
  event = 'BufWritePre',

  config = function()
    -- Import conform and configure formatters by filetype.
    local conform = require('conform')

    -- Define formatters for each filetype.
    -- Add or modify the formatters according to your requirements.
    conform.setup({
      formatters_by_ft = {
        python = {
          'black',  -- Popular Python formatter. Requires "black" to be installed.
          'isort',  -- Python import sorter. Requires "isort" to be installed.
        },
        javascript = { 'prettierd' }, -- JavaScript formatter. Requires "prettierd" to be installed.
        typescript = { 'prettierd' }, -- TypeScript formatter. Requires "prettierd" to be installed.
        lua = { 'stylua' },           -- Lua formatter. Requires "stylua" to be installed.
        go = { 'gofmt', 'goimports' }, -- Go formatters. Requires "gofmt" and "goimports" to be installed.
        rust = { 'rustfmt' },         -- Rust formatter. Requires "rustfmt" to be installed.
        json = { 'jq' },              -- JSON formatter. Requires "jq" to be installed.
        html = { 'prettierd' },       -- HTML formatter. Requires "prettierd" to be installed.
        css = { 'prettierd' },        -- CSS formatter. Requires "prettierd" to be installed.
        markdown = { 'prettierd' },   -- Markdown formatter. Requires "prettierd" to be installed.
        cpp = { 'clang-format' },   -- Markdown formatter. Requires "prettierd" to be installed.
        java = { 'google-java-format' },
      }
    })

    -- Automatically run formatters before saving a file.
    local format_autogroup = vim.api.nvim_create_augroup("format", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_autogroup,

      -- Run Conform's format function before writing to the file.
      callback = function()
        conform.format()
      end,
    })

    -- Define a keymap to trigger formatting manually.
    -- <leader> is a configurable prefix key in Neovim (often mapped to "\" or ",").
    vim.keymap.set("n", "<leader>cf", function()
      conform.format()
    end, { desc = "Run formatting" }) -- Add a description for better documentation and discoverability.
  end
}
