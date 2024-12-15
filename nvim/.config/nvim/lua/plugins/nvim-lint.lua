-- General purpose linters
return {
  -- Plugin URL: https://github.com/mfussenegger/nvim-lint
  -- This plugin provides a lightweight and flexible framework for integrating linters into Neovim.
  'mfussenegger/nvim-lint',

  -- The plugin will be loaded when a file is saved ("BufWritePost" event).
  event = 'BufWritePost',

  config = function()
    -- Define a table mapping filetypes to their corresponding linters.
    -- Filetypes are not the same as file extensions, but rather the language detected by Neovim.
    -- You can add or remove linters based on your requirements.
    require('lint').linters_by_ft = {
      python = {
        -- Uncomment any linters you want to use for Python files.
        -- 'flake8', -- Popular Python linter, requires "flake8" to be installed.
        -- 'mypy', -- Static type checker for Python, requires "mypy" to be installed.
        'pylint', -- General-purpose Python linter, requires "pylint" to be installed.
      },
      javascript = { 'eslint_d' }, -- Use "eslint_d" for JavaScript. Requires "eslint_d" to be installed.
      typescript = { 'eslint_d' }, -- Use "eslint_d" for TypeScript. Requires "eslint_d" to be installed.
    }

    -- Create a custom augroup (autocommand group) for managing lint-related autocommands.
    -- Augroups allow better organization and prevent duplication of autocommands.
    local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Define autocommands to automatically run linters in specific scenarios.
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      -- This autocommand group ensures the commands are managed together.
      group = lint_autogroup,

      -- The callback function is executed when the specified events occur.
      -- It runs the "try_lint" function from the nvim-lint plugin.
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Define a keymap to trigger linting manually.
    -- <leader> is a configurable prefix key in Neovim (often mapped to "\" or ",").
    vim.keymap.set("n", "<leader>lt", function()
      require("lint").try_lint()
    end, { desc = "Run linting" }) -- Add a description for better documentation and discoverability.
  end
}
