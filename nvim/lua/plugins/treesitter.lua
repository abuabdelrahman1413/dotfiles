
return{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
	config = function()
		
	    local config = require("nvim-treesitter.configs")
	    config.setup({
	    ensure_installed =
	    {
		    "lua", "javascript", "bash", "c", "html", "markdown", "vim",    "vimdoc", "python", "cpp"
	},
	highlight = { enable = true },
	indent = { enable = true }
	})
	end
}
