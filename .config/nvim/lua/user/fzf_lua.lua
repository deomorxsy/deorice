local fzflua = require("fzf_lua")
fzflua.setup({
	pickers = {},
	vimgrep_arguments = {
		vimgrep_arguments = {
			"rg",
			"--follow", -- Follow symbolic links
			"--hidden", -- Search for hidden files
			"--no-heading", -- Don't group matches by each file
			"--with-filename", -- Print the file path with the matched lines
			"--line-number", -- Show line numbers
			"--column", -- Show column numbers
			"--smart-case", -- Smart case search
			"--hidden-flags",
			"--no-ignore-vcs",

			-- Exclude some patterns from search
			"--glob=!**/.git/*",
			"--glob=!**/.idea/*",
			"--glob=!**/.vscode/*",
			"--glob=!**/build/*",
			"--glob=!**/dist/*",
			"--glob=!**/yarn.lock",
			"--glob=!**/package-lock.json",
			"--glob=!**/*org.eclipse.*", --eclipse/maven/java specific.
			"--glob=!**/*venv_nvim*",
		},
	},

	vim.keymap.set("n", "<leader>pf", function()
		require("fzf-lua").files()
	end),
	vim.keymap.set("n", "<leader>ps", function()
		require("fzf-lua").live_grep()
	end),
	vim.keymap.set("n", "<leader>pb", function()
		require("fzf-lua").buffers()
	end),
	vim.keymap.set("n", "<leader>ph", function()
		require("fzf-lua").help_tags()
	end),
})
