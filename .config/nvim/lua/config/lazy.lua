-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " " -- space
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		--{ import = "plugins.packerSpecs" },
		-- ### {

		-- ### 	"hrsh7th/nvim-cmp",
		-- ### 	enabled = true,
		-- ### 	event = "InsertEnter",
		-- ### 	config = function()
		-- ### 		local cmp = require("cmp")
		-- ### 		cmp.setup({
		-- ### 			sources = {
		-- ### 				{ name = "buffer" },
		-- ### 				{ name = "path" },
		-- ### 			},
		-- ### 		})
		-- ### 	end,
		-- ### 	dependencies = {
		-- ### 		"hrsh7th/cmp-buffer",
		-- ### 		"hrsh7th/cmp-path",
		-- ### 		"L3MON4D3/LuaSnip",
		-- ### 	},
		-- ### },

		-- depends on cmp_nvim
		-- ### {
		-- ### 	"nvim-telescope/telescope.nvim",
		-- ### 	-- version = "0.1.8",
		-- ### 	-- since there is only one version of telescope, use HEAD
		-- ### 	version = false,
		-- ### 	-- or, branch = '0.1.x',
		-- ### 	dependencies = { { "nvim-lua/plenary.nvim" } },
		-- ### },
		-- disable trouble
		{ "stevearc/conform.nvim", enabled = false },

		{
			"ibhagwan/fzf-lua",
			-- optional for icon support
			dependencies = { "nvim-tree/nvim-web-devicons" },
			-- or if using mini.icons/mini.nvim
			-- dependencies = { "nvim-mini/mini.icons" },
			---@module "fzf-lua"
			---@type fzf-lua.Config|{}
			---@diagnostics disable: missing-fields
			opts = {},
			---@diagnostics enable: missing-fields
		},

		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{ "mbbill/undotree" },
		{ "ms-jpq/coq_nvim", branch = "coq" },

		-- 9000+ Snippets
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },

		-- " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
		-- " Need to **configure separately**
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
		-- " - shell repl
		-- " - nvim lua api
		-- " - scientific calculator
		-- " - comment banner
		-- " - etc

		-- from: https://github.com/LazyVim/starter/blob/803bc181d7c0d6d5eeba9274d9be49b287294d99/lua/config/lazy.lua#L20
		-- add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		defaults = {
			lazy = false,
			version = false,
		},

		-- warning: disable due to switch to blink.cmp and to avoid cascading erros
		-- setup lsp for nvim-cmp
		-- ### {
		-- ### 	"hrsh7th/cmp-nvim-lsp",
		-- ### 	"hrsh7th/cmp-buffer",
		-- ### 	"hrsh7th/cmp-path",
		-- ### },

		-- https://github.com/hrsh7th/nvim-cmp
		-- https://www.lazyvim.org/extras/coding/nvim-cmp
		-- ### {
		-- ### 	"hrsh7th/nvim-cmp",
		-- ### 	version = false, -- last release is way too old, get git commit release
		-- ### 	event = "InsertEnter",
		-- ### 	dependencies = {
		-- ### 		"hrsh7th/cmp-nvim-lsp",
		-- ### 		"hrsh7th/cmp-buffer",
		-- ### 		"hrsh7th/cmp-path",
		-- ### 	},
		-- ### 	-- Not all LSP servers add brackets when completing a function.
		-- ### 	-- To better deal with this, LazyVim adds a custom option to cmp,
		-- ### 	-- that you can configure. For example:
		-- ### 	--
		-- ### 	-- ```lua
		-- ### 	-- opts = {
		-- ### 	--   auto_brackets = { "python" }
		-- ### 	-- }
		-- ### 	-- ```
		-- ### 	opts = function(_, opts)
		-- ### 		local has_words_before = function()
		-- ### 			unpack = unpack or table.unpack
		-- ### 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		-- ### 			return col ~= 0
		-- ### 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		-- ### 		end

		-- ### 		-- tab completion
		-- ### 		-- https://www.lazyvim.org/configuration/recipes
		-- ### 		local cmp = require("cmp_nvim_lsp")
		-- ### 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
		-- ### 			["<Tab>"] = cmp.mapping(function(fallback)
		-- ### 				if cmp.visible() then
		-- ### 					-- for vscode completion behavior: replace select_next_item with confirm({ select = true })
		-- ### 					cmp.select_next_item()
		-- ### 				elseif vim.snippet.active({ direction = 1 }) then
		-- ### 					vim.schedule(function()
		-- ### 						vim.snippet.jump(1)
		-- ### 					end)
		-- ### 				elseif has_words_before() then
		-- ### 					cmp.complete()
		-- ### 				else
		-- ### 					fallback()
		-- ### 				end
		-- ### 			end, { "i", "s" }),

		-- ### 			["<S-Tab>"] = cmp.mapping(function(fallback)
		-- ### 				if cmp.visible() then
		-- ### 					cmp.select_prev_item()
		-- ### 				elseif vim.snippet.active({ direction = -1 }) then
		-- ### 					vim.schedule(function()
		-- ### 						vim.snippet.jump(-1)
		-- ### 					end)
		-- ### 				else
		-- ### 					fallback()
		-- ### 				end
		-- ### 			end, { "i", "s" }),
		-- ### 		})

		-- ### 		-- Register nvim-cmp lsp capabilities
		-- ### 		vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

		-- ### 		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		-- ### 		local cmp = require("cmp_nvim_lsp")
		-- ### 		local defaults = require("cmp.config.default")()
		-- ### 		local auto_select = true
		-- ### 		return {
		-- ### 			auto_brackets = {}, -- configure any filetype to auto add brackets
		-- ### 			completion = {
		-- ### 				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
		-- ### 			},
		-- ### 			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
		-- ### 			mapping = cmp.mapping.preset.insert({
		-- ### 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- ### 				["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ### 				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		-- ### 				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		-- ### 				["<C-Space>"] = cmp.mapping.complete(),
		-- ### 				["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
		-- ### 				["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
		-- ### 				["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- ### 				["<C-CR>"] = function(fallback)
		-- ### 					cmp.abort()
		-- ### 					fallback()
		-- ### 				end,
		-- ### 				["<tab>"] = function(fallback)
		-- ### 					return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
		-- ### 				end,
		-- ### 			}),
		-- ### 			sources = cmp.config.sources({
		-- ### 				{ name = "lazydev" },
		-- ### 				{ name = "nvim_lsp" },
		-- ### 				{ name = "path" },
		-- ### 			}, {
		-- ### 				{ name = "buffer" },
		-- ### 			}),
		-- ### 			formatting = {
		-- ### 				format = function(entry, item)
		-- ### 					local icons = LazyVim.config.icons.kinds
		-- ### 					if icons[item.kind] then
		-- ### 						item.kind = icons[item.kind] .. item.kind
		-- ### 					end

		-- ### 					local widths = {
		-- ### 						abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
		-- ### 						menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
		-- ### 					}

		-- ### 					for key, width in pairs(widths) do
		-- ### 						if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
		-- ### 							item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
		-- ### 						end
		-- ### 					end

		-- ### 					return item
		-- ### 				end,
		-- ### 			},
		-- ### 			experimental = {
		-- ### 				-- only show ghost text when we show ai completions
		-- ### 				ghost_text = vim.g.ai_cmp and {
		-- ### 					hl_group = "CmpGhostText",
		-- ### 				} or false,
		-- ### 			},
		-- ### 			sorting = defaults.sorting,
		-- ### 		}
		-- ### 	end,
		-- ### 	main = "lazyvim.util.cmp",
		-- ### },

		-- ### -- lsp-zero
		-- ### {
		-- ###   'VonHeikemen/lsp-zero.nvim',
		-- ###   branch = 'v3.x',
		-- ###   dependencies = {
		-- ###     --- Uncomment these if you want to manage LSP servers from neovim
		-- ###     -- {'mason-org/mason.nvim'},
		-- ###     {
		-- ###         'mason-org/mason-lspconfig.nvim',
		-- ###         opts = {
		-- ###             ensure_installed = { "lua_ls", "rust_analyzer" },
		-- ###         },
		-- ###         dependencies = {
		-- ###             { "mason-org/mason.nvim", opts = {} },
		-- ###             "neovim/nvim-lspconfig",
		-- ###         },
		-- ###     },

		-- ###     -- Autocompletion
		-- ###     {
		-- ###         'hrsh7th/nvim-cmp',
		-- ###         event = 'InsertEnter',
		-- ###         config = function()
		-- ###             local cmp = require('cmp')

		-- ###             cmp.setup({
		-- ###                 sources = {
		-- ###                     {name = 'nvim_lsp'},
		-- ###                 },
		-- ###                 mapping = cmp.mapping.preset.insert({
		-- ###                     ['<C-space>'] = cmp.mapping.complete(),
		-- ###                     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
		-- ###                     ['<C-d>'] = cmp.mapping.scroll_docs(4),
		-- ###                 }),
		-- ###                 snippet = {
		-- ###                     expand = function(args)
		-- ###                         vim.snippet.expand(args.body)
		-- ###                     end,
		-- ###                 },
		-- ###             })
		-- ###         end
		-- ###     },

		-- ###     -- LSP Support
		-- ###     {
		-- ###         'neovim/nvim-lspconfig',
		-- ###         cmd = "LspInfo",
		-- ###         event = {'BufReadPre', 'BufNewFile'},
		-- ###         dependencies = {
		-- ###             -- Autocompletion
		-- ###             {'hrsh7th/cmp-nvim-lsp'},
		-- ###         },
		-- ###         opts = {
		-- ###             servers = {
		-- ###                 ['*'] = {
		-- ###                     keys = {
		-- ###                         -- add a keymap
		-- ###                         { "H", "<cmd>echo 'hello'<cr>", desc = "Say Hello" },
		-- ###                         -- Change an existing keymap
		-- ###                         { "K", "<cmd>echo 'custom hover'<cr>", desc = "Custom Hover" },
		-- ###                         -- Disable a keymap
		-- ###                         { "gd", false },

		-- ###                         -- old ones
		-- ###                         { "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "hmm..." },
		-- ###                         { "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "hmm..." },
		-- ###                         { "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "hmm..." },
		-- ###                         { "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "hmm..." },
		-- ###                         { "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "hmm..." },
		-- ###                         { "n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "hmm..." },
		-- ###                         { "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "hmm..." },
		-- ###                         { "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "hmm..." },
		-- ###                         { "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "hmm..." },
		-- ###                         { {"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "hmm..." },
		-- ###                         { "n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "hmm..." },

		-- ###                     },
		-- ###                 },
		-- ###             },
		-- ###         },
		-- ###     --},
		-- ###         init = function ()
		-- ###             -- local lsp_defaults = require('lspconfig').util.default_config
		-- ###             -- local lsp_defaults = vim.lsp.config().util.default_config
		-- ###             -- local hmm = vim.lsp.config.string.u
		-- ###             -- vim.lsp.config.
		-- ###             local lsp_defaults = vim.lsp.config

		-- ###             -- add cmp_nvim_lsp capabilities settings to lspconfig
		-- ###             -- this should be executed before you configure any language server
		-- ###             lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

		-- ###             -- LspAttach is used to enable features when
		-- ###             -- there is a language server active for the file
		-- ###             vim.api.nvim_create_autocmd('LspAttach', {
		-- ###                 desc = 'LSP actions',
		-- ###                 callback = function (event)
		-- ###                     local opts = {buffer = event.buf}

		-- ###                     vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- ###                     vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		-- ###                     vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		-- ###                     vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		-- ###                     vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

		-- ###                 end,
		-- ###             })

		-- ###             --require('lspconfig').gleam.setup({})
		-- ###             --require('lspconfig').ocamllsp.setup({})

		-- ###         end
		-- ###     },

		-- ###     -- Snippets
		-- ###     {'L3MON4D3/LuaSnip',lazy = true},

		-- ###     },
		-- ### },

		-- {'julian/lean.nvim'},
		-- -- julian's lean.nvim LSP
		--  {
		--      'julian/lean.nvim',
		--      dependencies = {
		--          'VonHeikemen/lsp-zero.nvim',
		--          --'neovim/nvim-lspconfig',
		--          'nvim-lua/plenary.nvim',

		--          -- Autocompletion
		--          -- below already is being imported by
		--          -- lsp-zero dependency tree

		--          --'hrsh7th/nvim-cmp',
		--          --'hrsh7th/cmp-nvim-lsp',
		--          --'hrsh7th/cmp-buffer',
		--          --'hrsh7th/cmp-path',
		--      },
		--      opts = {
		--          mappings = true,
		--      }
		--  },
		-- ### {
		-- ### 	"Julian/lean.nvim",
		-- ### 	event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		-- ### 	dependencies = {
		-- ### 		"nvim-lua/plenary.nvim",

		-- ### 		-- optional dependencies:

		-- ### 		-- a completion engine
		-- ### 		--    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices
		-- ### 		"hrsh7th/nvim-cmp",

		-- ### 		-- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
		-- ### 		-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
		-- ### 		-- 'andrewradev/switch.vim',        -- for switch support
		-- ### 		-- 'tomtom/tcomment_vim',           -- for commenting
		-- ### 	},

		-- ### 	---@type lean.Config
		-- ### 	opts = { -- see below for full configuration options
		-- ### 		mappings = true,
		-- ### 	},
		-- ### },

		-- "=====> https://github.com/andweeb/presence.nvim
		-- { 'andweeb/presence.nvim' }

		{
			"andweeb/presence.nvim",
			config = function()
				require("presence"):setup({
					-- General options
					auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
					neovim_image_text = ":ZZ", -- Text displayed when hovered over the Neovim image
					main_image = "neovim", -- Main image display (either "neovim" or "file")
					client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
					log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
					debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
					enable_line_number = false, -- Displays the current line number instead of the current project
					blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
					buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
					file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
					show_time = true, -- Show the timer

					-- Rich Presence text options
					editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
					file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
					git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
					plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
					reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
					workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
					line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
				})
			end,
		},

		-- "=====> ncm-R for Rscripts completion
		-- ### { "ncm2/ncm2" },
		-- ### { "roxma/nvim-yarp" },
		-- ### { "jalvesaq/Nvim-R" },
		-- ### { "gaalcaras/ncm-R" },

		-- "====> rust-analyzer dependencies

		-- " Use release branch (recommend)
		-- use ('neoclide/coc.nvim', {branch = 'master'})
		-- " Or build from source code by using yarn: https://yarnpkg.com
		-- use ('neoclide/coc.nvim', {
		--     branch = 'master',
		--     run = 'yarn install --frozen-lockfile'
		-- })

		-- eclipse LSP: jdtls for java
		-- " nvim-jdtls
		-- ### { "mfussenegger/nvim-jdtls" },

		-- " Vim 8 only
		-- uncomment on vim.init
		-- if !has('nvim')
		--     use ('roxma/vim-hug-neovim-rpc')
		--  endif

		-- Optional: for snippet support
		-- Further configuration might be required, read below
		-- ### { "sirver/UltiSnips" },
		-- ### { "ncm2/ncm2-ultisnips" },

		-- " Optional: better Rnoweb support (LaTeX completion)
		{
			"lervag/vimtex",
			lazy = false,
			init = function()
				vim.g.vimtex_compiler_latexmk_engines = {
					--_ = "-lualatex"
					_ = "-xelatex",
					--_ = "-pdf"
				}
				vim.g.vimtex_view_method = "skim"
			end,
		},

		-- interact with jupyter notebooks from neovim
		-- ### {
		-- ### 	"dccsillag/magma-nvim",
		-- ### 	build = ":UpdateRemotePlugins",
		-- ### 	config = function()
		-- ### 		vim.cmd("let g:magma_automatically_open_output = v:false")
		-- ### 		vim.keymap.set("n", "<leader>r", ":MagmaEvaluateOperator<CR>", { silent = true })
		-- ### 		vim.keymap.set("n", "<leader>rr", ":MagmaEvaluateLine<CR>", { silent = true })
		-- ### 		vim.keymap.set("x", "<leader>r", ":<C-u>MagmaEvaluateVisual<CR>", { silent = true })
		-- ### 		vim.keymap.set("n", "<leader>rc", ":MagmaReevaluateCell<CR>", { silent = true })
		-- ### 		vim.keymap.set("n", "<leader>rd", ":MagmaDelete<CR>", { silent = true })
		-- ### 		vim.keymap.set("n", "<leader>ro", ":MagmaShowOutput<CR>", { silent = true })
		-- ### 	end,
		-- ### },
		-- ### {
		-- ### 	"nvimtools/hydra.nvim",
		-- ### 	config = function()
		-- ### 		local Hydra = require("hydra")
		-- ### 		Hydra({
		-- ### 			-- create hydras
		-- ### 			name = "tiamat",
		-- ### 			mode = "n",
		-- ### 			body = "<leader>o",
		-- ### 			hint = [[
		-- ###         _h_: <- _l_: -> _q_: exit
		-- ###     ]],
		-- ### 			config = {
		-- ### 				-- see :h hydra-heads
		-- ### 				exit = false, -- set the default exit value for each head in the hydra

		-- ### 				-- decides what to do when a key which doesn't belong to any head is pressed
		-- ### 				--   nil: hydra exits and foreign key behaves normally, as if the hydra wasn't active
		-- ### 				--   "warn": hydra stays active, issues a warning and doesn't run the foreign key
		-- ### 				--   "run": hydra stays active, runs the foreign key
		-- ### 				foreign_keys = nil,

		-- ### 				-- see `:h hydra-colors`
		-- ### 				color = "red", -- "red" | "amaranth" | "teal" | "pink"

		-- ### 				-- define a hydra for the given buffer, pass `true` for current buf
		-- ### 				buffer = nil,

		-- ### 				-- when true, summon the hydra after pressing only the `body` keys. Normally a head is
		-- ### 				-- required
		-- ### 				invoke_on_body = true,

		-- ### 				-- description used for the body keymap when `invoke_on_body` is true
		-- ### 				desc = nil, -- when nil, "[Hydra] .. name" is used

		-- ### 				-- see :h hydra-hooks
		-- ### 				on_enter = nil, -- called when the hydra is activated
		-- ### 				on_exit = nil, -- called before the hydra is deactivated
		-- ### 				on_key = nil, -- called after every hydra head

		-- ### 				-- timeout after which the hydra is automatically disabled. Calling any head
		-- ### 				-- will refresh the timeout
		-- ### 				--   true: timeout set to value of 'timeoutlen' (:h 'timeoutlen')
		-- ### 				--   5000: set to desired number of milliseconds
		-- ### 				timeout = false, -- by default hydras wait forever

		-- ### 				-- see :h hydra-hint-hint-configuration
		-- ### 				hint = {
		-- ### 					position = "bottom",
		-- ### 					-- border = "rounded",
		-- ### 				},
		-- ### 			},
		-- ### 			heads = {
		-- ### 				{ "h", "<C-w>h", { desc = "Window left" } },
		-- ### 				{ "l", "<C-w>l", { desc = "Window right" } },
		-- ### 				{ "q", nil, { exit = true, desc = "Quit Hydra" } },
		-- ### 			},
		-- ### 		})
		-- ### 	end,
		-- ### },
		-- NotebookNavigator for Python REPL
		-- ### {

		-- ### 	"GCBallesteros/NotebookNavigator.nvim",
		-- ### 	keys = {
		-- ### 		{
		-- ### 			"]h",
		-- ### 			function()
		-- ### 				require("notebook-navigator").move_cell("d")
		-- ### 			end,
		-- ### 		},
		-- ### 		{
		-- ### 			"[h",
		-- ### 			function()
		-- ### 				require("notebook-navigator").move_cell("u")
		-- ### 			end,
		-- ### 		},
		-- ### 		{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
		-- ### 		{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		-- ### 	},
		-- ### 	dependencies = {
		-- ### 		"nvim-mini/mini.comment",
		-- ### 		"hkupty/iron.nvim", -- repl provider
		-- ### 		-- "akinsho/toggleterm.nvim", -- alternative repl provider
		-- ### 		-- "benlubas/molten-nvim", -- alternative repl provider
		-- ### 		--"anuvyklack/hydra.nvim",
		-- ### 	},
		-- ### 	event = "VeryLazy",
		-- ### 	config = function()
		-- ### 		local nn = require("notebook-navigator")
		-- ### 		nn.setup({
		-- ### 			cell_markers = {
		-- ### 				-- python = "# %%",
		-- ### 			},
		-- ### 			-- activate_hydra_keys = "<leader>h" ,
		-- ### 			-- show_hydra_hint = true,
		-- ### 			-- hydra_keys = {
		-- ### 			--     comment = "c",
		-- ### 			--     run = "X",
		-- ### 			--     run_and_move = "x",
		-- ### 			--     move_up = "k",
		-- ### 			--     move_down = "j",
		-- ### 			--     add_cell_before = "a",
		-- ### 			--     add_cell_after = "b",
		-- ### 			-- },
		-- ### 			repl_provider = "auto",
		-- ### 			syntax_highlight = false,
		-- ### 			cell_highlight_group = "Folded",
		-- ### 		})
		-- ### 	end,
		-- ### },
		--{
		--    config = function ()
		--        require("presence"):setup(){}
		--
		--    end
		--},

		-- nvim-platformio
		-- depends on telescope; check for adaptability in fzf-lua's case
		-- ### {
		-- ### 	"anurag3301/nvim-platformio.lua",
		-- ### 	dependencies = {
		-- ### 		{ "akinsho/nvim-toggleterm.lua" },
		-- ### 		{ "nvim-telescope/telescope.nvim" },
		-- ### 		{ "nvim-lua/plenary.nvim" },
		-- ### 	},
		-- ### },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	-- notify is relative to the messages at startup.
	checker = {
		enabled = true,
		notify = false,
	},
})
