return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"nvimdev/lspsaga.nvim",
			config = function()
				require("lspsaga").setup({})
			end,
		},
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "rust_analyzer", "tsserver" },
		})

		-- Diagnostics
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { desc = "", buffer = ev.buf }

				opts.desc = "Go to definition"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Go to implementation"
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Go to references"
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)

				opts.desc = ""
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end,
		})

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

		-- Go to

		require("lspconfig").lua_ls.setup({})
		require("lspconfig").rust_analyzer.setup({})
		require("lspconfig").tsserver.setup({})
	end,
}
