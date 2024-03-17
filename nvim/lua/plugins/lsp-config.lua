return {
	{"williamboman/mason.nvim",
	config = function()
		require("mason").setup()

		vim.keymap.set('n', '<leader>m', ':Mason<CR>')
	end
	},
	{"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
		ensure_installed ={
			"lua_ls", "pylsp", "bashls", "tsserver", "clangd", "cssls", "html"
		}
	})
	end
	},
	{    	"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({capabilities=capabilities})
			lspconfig.pylsp.setup({capabilities=capabilities})
			lspconfig.tsserver.setup({capabilities=capabilities})
			lspconfig.clangd.setup({capabilities=capabilities})
			lspconfig.ccls.setup({capabilities=capabilities})
			lspconfig.html.setup({capabilities=capabilities})
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
    			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    			vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
    			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
			vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    			vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		end
	}
}
