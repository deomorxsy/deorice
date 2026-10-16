
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


local lpeg = require 'lpeg'
local P, Cs = lpeg.P, lpeg.Cs
local any = P(1)
local re = lpeg.re
local p = re.compile([[
]])


call search('
:^;, \[/#### ```;, \[/g | :g/;, \[/norm! A```/g
^;, \[]')

if not (l.starts_line(';, [' * .nonnewline^0)) then
   print(string.format('[ERROR]: %s. Could not match pattern. Exiting now...', err))
   return 1
end

-- global substitution with re.gsub:
-- re.gsub (subject, pattern, replacement)
re.gsub(target, '^;, [', '#### ````;, [')

target = "You saw a dog and a cat"
print (string.match (target, "^dog"))

