local lsp_zero = require('lsp-zero')
--
-- lsp_zero.on_attach(function(client, bufnr)
--   local opts = {buffer = bufnr, remap = false}
--
--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--   vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--   vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--   vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)

require('mason').setup({})
require('mason-lspconfig').setup({
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
    ensure_installed = {'rust_analyzer', 'eslint', 'gopls'},
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,

        function(server_name)
            server_name = server_name == 'tssserver' and 'ts_ls' or server_name
            --if server_name == "tsserver" then
            --    server_name = "ts_ls"
            --end
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
  }
})

local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require("lsp-zero").cmp_action()


cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace, select=true
                }),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        --formatting = {
        --    format = require("lspkind").cmp_format({mode = "symbol"})
        --}
        --['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
    },
    formatting = lsp_zero.cmp_format(),
})

--local on_attach = require("plugins.configs.lspconfig").on_attach
--local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.gopls.setup {
    on_attach = lsp_zero.on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    cmd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
}
