-- turn on auto numebred lines
vim.o.number = true

-- spacing 
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- plugin loader
require("config.lazy")

-- appearance 
vim.cmd.colors("1989")

-- keymaps
vim.keymap.set({"n", "i", "v"}, "<C-s>", "<Cmd>w<CR>", { desc = "save >> :w --> CTRL + S" })

vim.keymap.set("i", "<C-Space>", "<Esc>", {desc = "exit insert mode"})

vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)

-- PLUGIN >> nvim-tree : keyboard control improvement 
vim.keymap.set({"n", "i"}, "<C-h>", "<Cmd> wincmd h <CR>", { desc = "nvim-tree: move to file-tree" })
vim.keymap.set({"n", "i"}, "<C-l>", "<Cmd> wincmd l <CR>", { desc = "nvim-tree: move to editor" })

-- better right arrow key 
vim.keymap.set({"i", "n"}, "<C-Right>", function()
  -- This is a test example . Test to your hearts content

	local mode = vim.fn.mode()

	local col = vim.api.nvim_win_get_cursor(0)[2] +1 -- x out of #LINE 
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local cur_string = line:sub(col)
	local cur_char = line:sub(col, col)
	local next_char = line:sub(col+1, col+1)
 
    -- is current char a "one letter word"? 
	local IS_SINGULAR = #vim.fn.expand('<cword>') == 1
    
    -- is cursor currently on last string? 
	local AT_LAST_STRING = not cur_string:match('%s+%S')
   
    -- is cursor at the last char of a string? 
	local AT_STRING_END = false
    
    -- setting mode_offset DOES NOT WORK with line:sub 
	if mode == 'i' then
		AT_STRING_END = cur_char:match('%s') or cur_char == ''
    else 
        AT_STRING_END = next_char:match('%s') or next_char == '' 
    end 

  -- prevent skipping over singular characters
	if IS_SINGULAR then
		vim.cmd('normal! l')
		return
	end
    
    -- if cursor in the middle of last string in a line 
    -- manually put the cursor at the end
    -- combinations of "e" motions don't work for last string in a line
    if AT_LAST_STRING and not AT_STRING_END then 
		vim.api.nvim_win_set_cursor(0, {row, #line})
		return
    end 
    
	if AT_STRING_END then
		vim.cmd('normal! w')
	else
		if mode == 'i' then vim.cmd('normal! el') else vim.cmd('normal! e') end
	end

end, { noremap = true, silent = true, desc = "right arrow movement goes: start of word >> end of word >> next word" })




