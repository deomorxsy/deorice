return {
	-- require('lspconfig') (the legacy "framework" of nvim-lspconfig)
	-- is deprecated in favor of vim.lsp.config (Nvim 0.11+).
	-- source: https://github.com/shushtain/nvim-lspconfig/blob/15a3fabe99db1cd87004a3a8d8f2df4281645c2e/README.md#important-%EF%B8%8a3fabe99db1cd87004a3a8d8f2df4281645c2e
	-- local
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	config = function()
		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		local servers = {
			gopls = {
				manual_install = true,
				settings = {
					lua_ls = {
						cmd = { "lua-language-server" },
					},
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			},
		}
		-- telescope config
		-- ### vim.api.nvim_createautocmd("LspAttach", {
		-- ### 	callback = function(args)
		-- ### 		local result = overridden(vim.g.err, vim.g.res, vim.g.ctx)
		-- ### 		local bufnr = args.buf
		-- ### 		local testClient = assert(vim.lsp.get_client_by_id.name)
		-- ### 		local client = assert(vim.lsp.get_client_by_id)
		-- ### 		if not client then
		-- ### 			return
		-- ### 		end

		-- ### 		local settings = servers[client.name]
		-- ### 		if type(settings) ~= "table" then
		-- ### 			settings = {}
		-- ### 		end

		-- ### 		local builtin = require("telescope.builtin")

		-- ### 		vim.keymap.set("n", "gd", function()
		-- ### 			vim.lsp.buf.definition()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "K", function()
		-- ### 			vim.lsp.buf.hover()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "<leader>vws", function()
		-- ### 			vim.lsp.buf.workspace_symbol()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "<leader>vd", function()
		-- ### 			vim.diagnostic.open_float()
		-- ### 		end, opts)
		-- ### 		-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.jump()
		-- ### 		-- https://neovim.io/doc/user/deprecated.html#vim.diagnostic.goto_next()
		-- ### 		vim.keymap.set("n", "[d", function()
		-- ### 			vim.diagnostic.jump({ count = 1, float = true })
		-- ### 		end, opts)
		-- ### 		-- https://neovim.io/doc/user/deprecated.html#vim.diagnostic.goto_prev()
		-- ### 		vim.keymap.set("n", "]d", function()
		-- ### 			vim.diagnostic.jump({ count = -1, float = true })
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "<leader>vca", function()
		-- ### 			vim.lsp.buf.code_action()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "<leader>vrr", function()
		-- ### 			vim.lsp.buf.references()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("n", "<leader>vrn", function()
		-- ### 			vim.lsp.buf.rename()
		-- ### 		end, opts)
		-- ### 		vim.keymap.set("i", "<C-h>", function()
		-- ### 			vim.lsp.buf.signature_help()
		-- ### 		end, opts)

		-- ### 		vim.keymap.set("n", "<space>ww", function()
		-- ### 			builtin.diagnostics({ root_dir = true })
		-- ### 		end, { buffer = 0 })

		-- ### 		-- traverse the attached buffer
		-- ### 		for bufnr, _ in ipairs(client.attached_buffers) do
		-- ### 			-- call your custom logic
		-- ### 			-- my_on_attach(client, bufnr)
		-- ### 		end
		-- ### 	end,
		-- ### })

		-- setup lsconfig
		local lspconfig = vim.lsp.config

		lspconfig.lua_ls.settings.setup({
			settings = {
				Lua = {
					runtime = {
						-- tell the language server which Lua runtime is being used
						-- (likely LuaJIT if using neovim)
						version = "LuaJIT",
					},

					diagnostics = {
						-- Setup the language server to recognize `vim` global
						globals = {
							"vim",
							"require",
						},
					},

					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},

					telemetry = {
						enable = false,
					},
				},
			},
		})

		local lsp_zero = require("lsp-zero")

		--lsp.preset('recommended')
		lsp_zero.preset("recommended")

		--lsp_zero.ensure_installed({ 'leanls' })
		--
		lsp_zero.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.jump()
			-- https://neovim.io/doc/user/deprecated.html#vim.diagnostic.goto_next()
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts)
			-- https://neovim.io/doc/user/deprecated.html#vim.diagnostic.goto_prev()
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end)

		-- require('mason').setup({})
		vim.lsp.config("mason")
		require("mason-lspconfig").setup({
			-- Will be called for each installed server that doesn't have
			-- a dedicated handler.
			--
			-- regarding tsserver -> ts_ls
			-- Q: "Why not just change the "tsserver" item in ensure_installed to "ts_ls" ?
			-- R: Because that would tell mason to install the ts_ls package and no such
			-- package exists. It only has tsserver"
			--
			-- tsserver/ts_ls is a Neovim port of Matt Pocock's ts-error-translator for VSCode
			-- for turning messy and confusing TypeScript errors into plain English.
			-- gopls also
			ensure_installed = { "rust_analyzer", "eslint" },

			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					-- require('lspconfig').lua_ls.setup(lua_opts)
					-- The `require('lspconfig')` "framework" is deprecated, use vim.lsp.config (see :help lspconfig-nvim-0.11) instead.
					-- Feature will be removed in nvim-lspconfig v3.0.0
					vim.lsp.config.lua_ls.setup(lua_opts)
				end,

				function(server_name)
					server_name = server_name == "tssserver" and "ts_ls" or server_name
					--if server_name == "tsserver" then
					--    server_name = "ts_ls"
					--end
					local mason_capabilities = require("cmp_nvim_lsp").default_capabilities()
					-- require("lspconfig")[server_name].setup({})
					-- The `require('lspconfig')` "framework" is deprecated, use vim.lsp.config (see :help lspconfig-nvim-0.11) instead.
					-- Feature will be removed in nvim-lspconfig v3.0.0
					vim.lsp.config.lua_ls.setup({
						capabilities = mason_capabilities,
					})
				end,
			},
		})

		--local
		local cmp = require("cmp_nvim_lsp")
		--local cmp_select = {behavior = cmp.SelectBehavior.Select}
		-- local
		-- ### cmp_action = require("lsp-zero").cmp_action()

		-- ### cmp.setup({
		-- ### 	mapping = cmp.mapping.preset.insert({
		-- ### 		["<CR>"] = cmp.mapping.confirm({
		-- ### 			behavior = cmp.ConfirmBehavior.Replace,
		-- ### 			select = true,
		-- ### 		}),
		-- ### 		["<Tab>"] = cmp_action.luasnip_supertab(),
		-- ### 		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		-- ### 		--formatting = {
		-- ### 		--    format = require("lspkind").cmp_format({mode = "symbol"})
		-- ### 		--}
		-- ### 		--['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		-- ### 		--['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		-- ### 		["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ### 		["<C-n>"] = cmp.mapping.select_next_item(),
		-- ### 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- ### 		["<C-Space>"] = cmp.mapping.complete(),
		-- ### 	}),
		-- ### 	sources = {
		-- ### 		{ name = "path" },
		-- ### 		{ name = "nvim_lsp" },
		-- ### 		{ name = "nvim_lua" },
		-- ### 	},
		-- ### 	formatting = lsp_zero.cmp_format(),
		-- ### })

		--local on_attach = require("plugins.configs.lspconfig").on_attach
		--local capabilities = require("plugins.configs.lspconfig").capabilities

		-- local lspconfig = require("lspconfig")
		-- local util = require "lspconfig/util"
		-- local lspconfig = vim.lsp.config
		-- local util = lspconfig.util

		-- lspconfig.gopls.setup({
		--     on_attach = lsp_zero.on_attach,
		--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
		--     cmd = {"gopls"},
		--     filetypes = { "go", "gomod", "gowork", "gotmpl" },
		--     root_dir = util.root_pattern("go.work", "go.mod", ".git"),
		-- })

		lspconfig("gopls", {
			on_attach = lsp_zero.on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = lspconfig("util", { cmd = { "true" } }).root_pattern("go.work", "go.mod", ".git"),
			-- root_dir = vim.lsp.config["util"].root_pattern("go.work", "go.mod", ".git"),
			-- vim.lsp.config("util", {}).root_pattern
		})

		lsp_zero.setup()
	end,
}
