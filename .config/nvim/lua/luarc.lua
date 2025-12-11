return {
    luarc = {
        lua_ls = {
            log_level = vim.lsp.log_levels.TRACE,
            -- https://github.com/pynappo/dotfiles/blob/2aa3ff1383fa1f85a0ceff0db1e25cc58f0f91a1/.config/nvim/lua/pynappo/lsp/configs.lua#L14-L45
            on_init = function(client)
                local path = vim.tbl_get(client, 'workspace_folders', 1, 'name')
                if not path then return true end
                local nvim_workspace = path:find('nvim') or path:find('lua')
                local test_nvim = path:find('test')
                if nvim_workspace then
                    local library = test_nvim and { vim.env.VIMRUNTIME } or vim.api.nvim_get_runtime_file('lua', true)
                    -- lazy-loaded plugins
                    if package.loaded['lazy'] then
                        for _, plugin in ipairs(require('lazy').plugins()) do
                            local lua_plugin_dir = plugin.dir .. '/lua'
                            if not plugin._.loaded and vim.uv.fs_stat(lua_plugin_dir) then table.insert(library, lua_plugin_dir) end
                        end
                    end
                    library = vim.tbl_map(function(lib) return vim.fs.normalize(lib) end, library)
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                pathStrict = true,
                            },
                            workspace = {
                                library = library,
                            },
                        },
                    })
                    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
                end
                return true
            end,
            -- deprecated: require'lspconfig'.sumneko_lua.setup
            settings = {
                Lua = {
                    runtime = {
                        -- tell the language server which Lua runtime is being used
                        -- (likely LuaJIT if using neovim)
                        version = "LuaJIT",

                        -- version = "Lua 5.5",
                        -- version = "Lua 5.4",
                        -- version = "Lua 5.3",
                        -- version = "Lua 5.2",
                        -- version = "Lua 5.1",
                    },

                    diagnostics = {
                        -- Setup the language server to recognize `vim` global
                        globals = {
                            "vim",
                            "require"
                        },
                    },

                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true)
                    },

                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
    },
}
