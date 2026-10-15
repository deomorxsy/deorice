
M = {}

if _VERSION == 'Lua 5.1' or _VERSION == 'Lua 5.2' then
	error('lpeg.vim needs Lua 5.3 or newer')
	return nil
end

local ok_lexer, lexer = xpcall(require, function(err)
    print('Error: ' ..err)
end, lexer_file or '')
if not ok_lexer then
    print(string.format('error loading: %s', lexer_file))
    return nil
end
if alt_name then
    lexer._NAME = alt_name
end


local ok, _ = xpcall(require, function(err)
	print('deorice.vim: ' .. err:sub(0, err:find('\n') - 2))
end, 'lpeg')
if not ok then
	return nil
end


call search('
:^;, \[/#### ```;, \[/g | :g/;, \[/norm! A```/g
^;, \[]')

