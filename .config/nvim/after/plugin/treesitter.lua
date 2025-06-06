 require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers should always be installed)
  ensure_installed = {
      "c", "rust", "lua", "javascript", "typescript", "vim",
      "vimdoc", "query", "java", "python", "r", "go", "bash",
      "perl", "haskell", "elixir", "ocaml", "erlang", "make",
      "dockerfile", "nix", "yaml", "toml", "scala", "html",
      "css", "vue", "sql", "zig", "clojure", "gleam",
      "fsharp", "agda", "idris", "purescript",
      "swift", "scheme", "racket",

  },
  --
  -- yet to be added: raku,
  --
  -- ensure_notes:
  -- haskell-language-server will need the ghcup package manager installed.
  --
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
