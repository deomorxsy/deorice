vim.opt.laststatus = 2

local hl_colors = { -- highlights presets
    {'StatusType', {bg='#ff0000', fg='#1d2021'}},
    {'StatusFile', {bg='#fabd2f', fg='#1d2021'}},
    {'StatusModified', {bg='#1d2021', fg='#d3869b'}},
    {'StatusBuffer', {bg='#98971a', fg='#1d2021'}},
    {'StatusLocation', {bg='#458588', fg='#1d2021'}},
    {'StatusPercent', {bg='#1d2021', fg='#ebdbb2'}},
    {'StatusNorm', {bg='none', fg='red'}},
}

local hl_colors_var = { --other hi presets
  {'StatusLine', { fg = '#3C3836', bg = '#EBDBB2' }},
  {'StatusLineNC', { fg = '#3C3836', bg = '#928374' }},
  {'Mode', { bg = '#928374', fg = '#1D2021', gui="bold" }},
  {'LineCol', { bg = '#928374', fg = '#1D2021', gui="bold" }},
  {'Git', { bg = '#504945', fg = '#EBDBB2' }},
  {'Filetype', { bg = '#504945', fg = '#EBDBB2' }},
  {'Filename', { bg = '#504945', fg = '#EBDBB2' }},
  {'ModeAlt', { bg = '#504945', fg = '#928374' }},
  {'GitAlt', { bg = '#3C3836', fg = '#504945' }},
  {'LineColAlt', { bg = '#504945', fg = '#928374' }},
  {'FiletypeAlt', { bg = '#3C3836', fg = '#504945' }},
}

local set_hlc = function(group, options)
    local frgd = (options.fg and options.fg == '') or ('guifg=' .. options.fg) or ''
    local bkgd = (options.bg and options.bg == '') or ('guibg=' .. options.bg) or ''
    local gui = (options.gui and options.gui ~= '' and 'gui=' .. options.gui) or ''

    vim.cmd(string.format('hi %s %s %s %s', group, bkgd, frgd, gui))
end

for _, hi in ipairs(hl_colors_var) do -- highlights
    set_hlc(hi[1], hi[2])
end



-- ================
-- mode indicator
-- ================

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

Statusline = {}
Statusline.active = function()
    return table.concat({
        "%#Statusline#",
        mode(),
        --"%#Normal# ",
        "%#StatusModified#",
        "<< ",
        "%#StatusFile#",
        ">> ",
        "%F",
        " >>",
        "%#StatusModified#",
        " ",
        "%m",
        " ",
        "%#StatusNorm#",
        "%=",
        "%#StatusBuffer#",
        "<< ",
        " ",
        --"%n",
        " >>",
        "%#StatusLocation#",
        "<< ",
        --" %#StatusType#",
        "%y ", -- file format
        "%l, %c",
        " >>",
        "%#StatusPercent#",
        "<< ",
        "%p%%  ",
        " >>"

    })
end

Statusline.inactive = function()
    return " %F"
end

Statusline.short = function()
    return "%#StatusLineNC# NvimTree"
end

-- ================
-- display statusline
-- ================

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

