-- lidsa

local api = vim.api
-- local S = {}
return {
    fromScratch = function ()
        api.nvim_command('enew') -- :enew
        vim.bo[0].buftype=nofile -- set current buffer (buffer 0) buftype to nofile
        vim.bo[0].bufhidden=hide
        vim.bo[0].swapfile=false
    end,
}
