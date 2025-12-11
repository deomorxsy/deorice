return {

	-- require("nvim-treesitter.configs").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		event = "BufRead",
		branch = "main",
		build = ":TSUpdate",
		---@class TSConfig
		---
		opts = {
			-- A list of parser names, or "all" (the listed parsers should always be installed)
			ensure_installed = {
				"c",
				"rust",
				"lua",
				"javascript",
				"typescript",
				"vim",
				"vimdoc",
				"query",
				"java",
				"python",
				"r",
				"go",
				"bash",
				"perl",
				"haskell",
				"elixir",
				"ocaml",
				"erlang",
				"make",
				"dockerfile",
				"nix",
				"yaml",
				"toml",
				"scala",
				"html",
				"css",
				"vue",
				"sql",
				"zig",
				"clojure",
				"gleam",
				"fsharp",
				"agda",
				"idris",
				"purescript",
				"swift",
				"scheme",
				"racket",
			},
			highlight = { enable = true },
			ident = { enable = true },
		},

		config = function(_, opts)
			-- install parsers from custom opts.ensure_installed
			if opts.ensure_installed and #opts.ensure_installed > 0 then
				require("nvim-treesitter").install(opts.ensure_installed)
				-- register and start parsers for filetypes
				for _, parser in ipairs(opts.ensure_installed) do
					local filetypes = parser -- In this case, parser is the filetype/language name

					vim.treesitter.language.register(parser, filetypes)

					vim.api.nvim_create_autocmd({ "FileType" }, {
						pattern = filetypes,
						callback = function(event)
							vim.treesitter.start(event.buf, parser)
						end,
					})
				end
			end
		end,
	},
}
