return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
	local ts = require('nvim-treesitter.configs')
	ts.setup({
	    highlight = { enable = true},
	    indent = {enable = true},
	      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "tsx", "typescript", "html", "css", "json", "php" },

	})
    end
}
