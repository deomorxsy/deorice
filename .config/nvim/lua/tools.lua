-- lidsa

api = vim.api
local S = {}
function S.fromScratch()
    api.nvim_command('enew') -- :enew
    vim.bo[0].buftype=nofile -- set current buffer (buffer 0) buftype to nofile
    vim.bo[0].bufhidden=hide
    vim.bo[0].swapfile=false
end
return S
