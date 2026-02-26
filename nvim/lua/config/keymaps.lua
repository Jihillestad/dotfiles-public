-- =============================================================================
-- Title: keymaps.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/config/keymaps.lua
-- About: Custom keymaps configuraion including functions for more advanced
-- keymaps
-- Credits: Linkarzu's dotfiles have helped med take this to the next level,
-- especially the markdown stuff.
-- Sources:
-- - https://github.com/linkarzu/dotfiles-latest/
-- =============================================================================

-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap -- for conciseness

-- =============================================================================
-- General Section
-- =============================================================================

-- Page Up/Down center page override
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- When searching for stuff, search results show in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Move lines up/down
keymap.set("n", "<leader>lj", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<leader>lk", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<leader>lj", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<leader>lk", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Better indenting in visual mode
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- window management
-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>=", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- keymap.set("n", "<leader>ss", "<C-w>x", { desc = "Swap window with next" }) -- make split windows equal width & height
-- keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- =============================================================================
-- Markdown Section
-- =============================================================================

-- Call which-key to show the markdown keybindings when <leader>m is pressed in
-- normal or visual mode
local wk = require("which-key")

wk.add({
	{
		mode = { "n", "v" },
		{ "<leader>m", group = "[P]markdown" },
		{ "<leader>mf", group = "[P]fold" },
		{ "<leader>mt", group = "[P]TOC" },
		{ "<leader>mh", group = "[P]headings increase/decrease" },
		{ "<leader>ml", group = "[P]links" },
		{ "<leader>ms", group = "[P]spell" },
		{ "<leader>msl", group = "[P]language" },
	},
})

-- Toggle bullet point at the beginning of the current line in normal mode
-- If in a multiline paragraph, make sure the cursor is on the line at the top
-- "d" is for "dash" lamw25wmal
vim.keymap.set("n", "<leader>md", function()
	-- Get the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local current_buffer = vim.api.nvim_get_current_buf()
	local start_row = cursor_pos[1] - 1
	local col = cursor_pos[2]
	-- Get the current line
	local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
	-- Check if the line already starts with a bullet point
	if line:match("^%s*%-") then
		-- Remove the bullet point from the start of the line
		line = line:gsub("^%s*%-", "")
		vim.api.nvim_buf_set_lines(current_buffer, start_row, start_row + 1, false, { line })
		return
	end
	-- Search for newline to the left of the cursor position
	local left_text = line:sub(1, col)
	local bullet_start = left_text:reverse():find("\n")
	if bullet_start then
		bullet_start = col - bullet_start
	end
	-- Search for newline to the right of the cursor position and in following lines
	local right_text = line:sub(col + 1)
	local bullet_end = right_text:find("\n")
	local end_row = start_row
	while not bullet_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
		end_row = end_row + 1
		local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
		if next_line == "" then
			break
		end
		right_text = right_text .. "\n" .. next_line
		bullet_end = right_text:find("\n")
	end
	if bullet_end then
		bullet_end = col + bullet_end
	end
	-- Extract lines
	local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
	local text = table.concat(text_lines, "\n")
	-- Add bullet point at the start of the text
	local new_text = "- " .. text
	local new_lines = vim.split(new_text, "\n")
	-- Set new lines in buffer
	vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
end, { desc = "[P]Toggle bullet point (dash)" })

-- Toggle bullet point at the beginning of the current line in normal mode
-- If in a multiline paragraph, make sure the cursor is on the line at the top
-- "d" is for "dash" lamw25wmal
vim.keymap.set("n", "<leader>md", function()
	-- Get the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local current_buffer = vim.api.nvim_get_current_buf()
	local start_row = cursor_pos[1] - 1
	local col = cursor_pos[2]
	-- Get the current line
	local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
	-- Check if the line already starts with a bullet point
	if line:match("^%s*%-") then
		-- Remove the bullet point from the start of the line
		line = line:gsub("^%s*%-", "")
		vim.api.nvim_buf_set_lines(current_buffer, start_row, start_row + 1, false, { line })
		return
	end
	-- Search for newline to the left of the cursor position
	local left_text = line:sub(1, col)
	local bullet_start = left_text:reverse():find("\n")
	if bullet_start then
		bullet_start = col - bullet_start
	end
	-- Search for newline to the right of the cursor position and in following lines
	local right_text = line:sub(col + 1)
	local bullet_end = right_text:find("\n")
	local end_row = start_row
	while not bullet_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
		end_row = end_row + 1
		local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
		if next_line == "" then
			break
		end
		right_text = right_text .. "\n" .. next_line
		bullet_end = right_text:find("\n")
	end
	if bullet_end then
		bullet_end = col + bullet_end
	end
	-- Extract lines
	local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
	local text = table.concat(text_lines, "\n")
	-- Add bullet point at the start of the text
	local new_text = "- " .. text
	local new_lines = vim.split(new_text, "\n")
	-- Set new lines in buffer
	vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
end, { desc = "[P]Toggle bullet point (dash)" })

-- HACK: Manage Markdown tasks in Neovim similar to Obsidian | Telescope to List Completed and Pending Tasks
-- https://youtu.be/59hvZl077hM
--
-- If there is no `untoggled` or `done` label on an item, mark it as done
-- and move it to the "## completed tasks" markdown heading in the same file, if
-- the heading does not exist, it will be created, if it exists, items will be
-- appended to it at the top lamw25wmal
--
-- If an item is moved to that heading, it will be added the `done` label
vim.keymap.set("n", "<M-x>", function()
	-- Customizable variables
	-- NOTE: Customize the completion label
	local label_done = "done:"
	-- NOTE: Customize the timestamp format
	local timestamp = os.date("%y%m%d-%H%M")
	-- local timestamp = os.date("%y%m%d")
	-- NOTE: Customize the heading and its level
	local tasks_heading = "## Completed Tasks"
	-- Save the view to preserve folds
	vim.cmd("mkview")
	local api = vim.api
	-- Retrieve buffer & lines
	local buf = api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_line = cursor_pos[1] - 1
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local total_lines = #lines
	-- If cursor is beyond last line, do nothing
	if start_line >= total_lines then
		vim.cmd("loadview")
		return
	end
	------------------------------------------------------------------------------
	-- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
	------------------------------------------------------------------------------
	while start_line > 0 do
		local line_text = lines[start_line + 1]
		-- Stop if we find a blank line or a bullet line
		if line_text == "" or line_text:match("^%s*%-") then
			break
		end
		start_line = start_line - 1
	end
	-- Now we might be on a blank line or a bullet line
	if lines[start_line + 1] == "" and start_line < (total_lines - 1) then
		start_line = start_line + 1
	end
	------------------------------------------------------------------------------
	-- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
	------------------------------------------------------------------------------
	local bullet_line = lines[start_line + 1]
	if not bullet_line:match("^%s*%- %[[x ]%]") then
		-- Not a task bullet => show a message and return
		print("Not a task bullet: no action taken.")
		vim.cmd("loadview")
		return
	end
	------------------------------------------------------------------------------
	-- 1. Identify the chunk boundaries
	------------------------------------------------------------------------------
	local chunk_start = start_line
	local chunk_end = start_line
	while chunk_end + 1 < total_lines do
		local next_line = lines[chunk_end + 2]
		if next_line == "" or next_line:match("^%s*%-") then
			break
		end
		chunk_end = chunk_end + 1
	end
	-- Collect the chunk lines
	local chunk = {}
	for i = chunk_start, chunk_end do
		table.insert(chunk, lines[i + 1])
	end
	------------------------------------------------------------------------------
	-- 2. Check if chunk has [done: ...] or [untoggled], then transform them
	------------------------------------------------------------------------------
	local has_done_index = nil
	local has_untoggled_index = nil
	for i, line in ipairs(chunk) do
		-- Replace `[done: ...]` -> `` `done: ...` ``
		chunk[i] = line:gsub("%[done:([^%]]+)%]", "`" .. label_done .. "%1`")
		-- Replace `[untoggled]` -> `` `untoggled` ``
		chunk[i] = chunk[i]:gsub("%[untoggled%]", "`untoggled`")
		if chunk[i]:match("`" .. label_done .. ".-`") then
			has_done_index = i
			break
		end
	end
	if not has_done_index then
		for i, line in ipairs(chunk) do
			if line:match("`untoggled`") then
				has_untoggled_index = i
				break
			end
		end
	end
	------------------------------------------------------------------------------
	-- 3. Helpers to toggle bullet
	------------------------------------------------------------------------------
	-- Convert '- [ ]' to '- [x]'
	local function bulletToX(line)
		return line:gsub("^(%s*%- )%[%s*%]", "%1[x]")
	end
	-- Convert '- [x]' to '- [ ]'
	local function bulletToBlank(line)
		return line:gsub("^(%s*%- )%[x%]", "%1[ ]")
	end
	------------------------------------------------------------------------------
	-- 4. Insert or remove label *after* the bracket
	------------------------------------------------------------------------------
	local function insertLabelAfterBracket(line, label)
		local prefix = line:match("^(%s*%- %[[x ]%])")
		if not prefix then
			return line
		end
		local rest = line:sub(#prefix + 1)
		return prefix .. " " .. label .. rest
	end
	local function removeLabel(line)
		-- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
		-- '- [x]' or '- [ ]', remove it
		return line:gsub("^(%s*%- %[[x ]%])%s+`.-`", "%1")
	end
	------------------------------------------------------------------------------
	-- 5. Update the buffer with new chunk lines (in place)
	------------------------------------------------------------------------------
	local function updateBufferWithChunk(new_chunk)
		for idx = chunk_start, chunk_end do
			lines[idx + 1] = new_chunk[idx - chunk_start + 1]
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	end
	------------------------------------------------------------------------------
	-- 6. Main toggle logic
	------------------------------------------------------------------------------
	if has_done_index then
		chunk[has_done_index] = removeLabel(chunk[has_done_index]):gsub("`" .. label_done .. ".-`", "`untoggled`")
		chunk[1] = bulletToBlank(chunk[1])
		chunk[1] = removeLabel(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`untoggled`")
		updateBufferWithChunk(chunk)
		vim.notify("Untoggled", vim.log.levels.INFO)
	elseif has_untoggled_index then
		chunk[has_untoggled_index] =
			removeLabel(chunk[has_untoggled_index]):gsub("`untoggled`", "`" .. label_done .. " " .. timestamp .. "`")
		chunk[1] = bulletToX(chunk[1])
		chunk[1] = removeLabel(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
		updateBufferWithChunk(chunk)
		vim.notify("Completed", vim.log.levels.INFO)
	else
		-- Save original window view before modifications
		local win = api.nvim_get_current_win()
		local view = api.nvim_win_call(win, function()
			return vim.fn.winsaveview()
		end)
		chunk[1] = bulletToX(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
		-- Remove chunk from the original lines
		for i = chunk_end, chunk_start, -1 do
			table.remove(lines, i + 1)
		end
		-- Append chunk under 'tasks_heading'
		local heading_index = nil
		for i, line in ipairs(lines) do
			if line:match("^" .. tasks_heading) then
				heading_index = i
				break
			end
		end
		if heading_index then
			for _, cLine in ipairs(chunk) do
				table.insert(lines, heading_index + 1, cLine)
				heading_index = heading_index + 1
			end
			-- Remove any blank line right after newly inserted chunk
			local after_last_item = heading_index + 1
			if lines[after_last_item] == "" then
				table.remove(lines, after_last_item)
			end
		else
			table.insert(lines, tasks_heading)
			for _, cLine in ipairs(chunk) do
				table.insert(lines, cLine)
			end
			local after_last_item = #lines + 1
			if lines[after_last_item] == "" then
				table.remove(lines, after_last_item)
			end
		end
		-- Update buffer content
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.notify("Completed", vim.log.levels.INFO)
		-- Restore window view to preserve scroll position
		api.nvim_win_call(win, function()
			vim.fn.winrestview(view)
		end)
	end
	-- Write changes and restore view to preserve folds
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	vim.cmd("loadview")
end, { desc = "[P]Toggle task and move it to 'done'" })

-- Keymap to switch spelling language to English lamw25wmal
-- To save the language settings configured on each buffer, you need to add
-- "localoptions" to vim.opt.sessionoptions in the `lua/config/options.lua` file
vim.keymap.set("n", "<leader>msle", function()
	vim.opt.spelllang = "en"
	vim.cmd("echo 'Spell language set to English'")
end, { desc = "[P]Spelling language English" })

-- Keymap to switch spelling language to Norwegian lamw25wmal
vim.keymap.set("n", "<leader>msln", function()
	vim.opt.spelllang = "nb"
	vim.cmd("echo 'Spell language set to Norwegian'")
end, { desc = "[P]Spelling language Norwegian" })

-- HACK: neovim spell multiple languages
-- https://youtu.be/uLFAMYFmpkE
--
-- Keymap to switch spelling language to both spanish and english lamw25wmal
vim.keymap.set("n", "<leader>mslb", function()
	vim.opt.spelllang = "en,nb"
	vim.cmd("echo 'Spell language set to Norwegian and English'")
end, { desc = "[P]Spelling language Norwegian and English" })

-- Show spelling suggestions / spell suggestions
-- NOTE: I changed this to accept the first spelling suggestion
vim.keymap.set("n", "<leader>mss", function()
	-- Simulate pressing "z=" with "m" option using feedkeys
	-- vim.api.nvim_replace_termcodes ensures "z=" is correctly interpreted
	-- 'm' is the {mode}, which in this case is 'Remap keys'. This is default.
	-- If {mode} is absent, keys are remapped.
	--
	-- I tried this keymap as usually with
	vim.cmd("normal! 1z=")
	-- But didn't work, only with nvim_feedkeys
	-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("z=", true, false, true), "m", true)
end, { desc = "[P]Spelling suggestions" })

-- markdown good, accept spell suggestion
-- Add word under the cursor as a good word
vim.keymap.set("n", "<leader>msg", function()
	vim.cmd("normal! zg")
	-- I do a write so that harper is updated
	vim.cmd("silent write")
end, { desc = "[P]Spelling add word to spellfile" })

-- Undo zw, remove the word from the entry in 'spellfile'.
vim.keymap.set("n", "<leader>msu", function()
	vim.cmd("normal! zug")
end, { desc = "[P]Spelling undo, remove word from list" })

-- Repeat the replacement done by |z=| for all matches with the replaced word
-- in the current window.
vim.keymap.set("n", "<leader>msr", function()
	-- vim.cmd(":spellr")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":spellr\n", true, false, true), "m", true)
end, { desc = "[P]Spelling repeat" })

-- Remap 'gss' to 'gsa`' in visual mode
-- This surrounds with inline code, that I use a lot lamw25wmal
vim.keymap.set("v", "gss", function()
	-- Use nvim_replace_termcodes to handle special characters like backticks
	local keys = vim.api.nvim_replace_termcodes("gsa`", true, false, true)
	-- Feed the keys in visual mode ('x' for visual mode)
	vim.api.nvim_feedkeys(keys, "x", false)
	-- I tried these 3, but they didn't work, I assume because of the backtick character
	-- vim.cmd("normal! gsa`")
	-- vim.cmd([[normal! gsa`]])
	-- vim.cmd("normal! gsa\\`")
end, { desc = "[P] Surround selection with backticks (inline code)" })

-- This surrounds CURRENT WORD with inline code in NORMAL MODE lamw25wmal
vim.keymap.set("n", "gss", function()
	-- Use nvim_replace_termcodes to handle special characters like backticks
	local keys = vim.api.nvim_replace_termcodes("gsaiw`", true, false, true)
	-- Feed the keys in visual mode ('x' for visual mode)
	vim.api.nvim_feedkeys(keys, "x", false)
	-- I tried these 3, but they didn't work, I assume because of the backtick character
	-- vim.cmd("normal! gsa`")
	-- vim.cmd([[normal! gsa`]])
	-- vim.cmd("normal! gsa\\`")
end, { desc = "[P] Surround selection with backticks (inline code)" })

-- In visual mode, check if the selected text is already striked through and show a message if it is
-- If not, surround it
vim.keymap.set("v", "<leader>mx", function()
	-- Get the selected text range
	local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
	local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
	local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
	if selected_text:match("^%~%~.*%~%~$") then
		vim.notify("Text already has strikethrough", vim.log.levels.INFO)
	else
		vim.cmd("normal 2gsa~")
	end
end, { desc = "[P]Strike through current selection" })

-- In visual mode, check if the selected text is already bold and show a message if it is
-- If not, surround it with double asterisks for bold
vim.keymap.set("v", "<leader>mb", function()
	-- Get the selected text range
	local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
	local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
	local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
	if selected_text:match("^%*%*.*%*%*$") then
		vim.notify("Text already bold", vim.log.levels.INFO)
	else
		vim.cmd("normal 2gsa*")
	end
end, { desc = "[P]BOLD current selection" })

-- -- Multiline unbold attempt
-- -- In normal mode, bold the current word under the cursor
-- -- If already bold, it will unbold the word under the cursor
-- -- If you're in a multiline bold, it will unbold it only if you're on the
-- -- first line
vim.keymap.set("n", "<leader>mb", function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local current_buffer = vim.api.nvim_get_current_buf()
	local start_row = cursor_pos[1] - 1
	local col = cursor_pos[2]
	-- Get the current line
	local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
	-- Check if the cursor is on an asterisk
	if line:sub(col + 1, col + 1):match("%*") then
		vim.notify("Cursor is on an asterisk, run inside the bold text", vim.log.levels.WARN)
		return
	end
	-- Search for '**' to the left of the cursor position
	local left_text = line:sub(1, col)
	local bold_start = left_text:reverse():find("%*%*")
	if bold_start then
		bold_start = col - bold_start
	end
	-- Search for '**' to the right of the cursor position and in following lines
	local right_text = line:sub(col + 1)
	local bold_end = right_text:find("%*%*")
	local end_row = start_row
	while not bold_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
		end_row = end_row + 1
		local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
		if next_line == "" then
			break
		end
		right_text = right_text .. "\n" .. next_line
		bold_end = right_text:find("%*%*")
	end
	if bold_end then
		bold_end = col + bold_end
	end
	-- Remove '**' markers if found, otherwise bold the word
	if bold_start and bold_end then
		-- Extract lines
		local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
		local text = table.concat(text_lines, "\n")
		-- Calculate positions to correctly remove '**'
		-- vim.notify("bold_start: " .. bold_start .. ", bold_end: " .. bold_end)
		local new_text = text:sub(1, bold_start - 1) .. text:sub(bold_start + 2, bold_end - 1) .. text:sub(bold_end + 2)
		local new_lines = vim.split(new_text, "\n")
		-- Set new lines in buffer
		vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
	-- vim.notify("Unbolded text", vim.log.levels.INFO)
	else
		-- Bold the word at the cursor position if no bold markers are found
		local before = line:sub(1, col)
		local after = line:sub(col + 1)
		local inside_surround = before:match("%*%*[^%*]*$") and after:match("^[^%*]*%*%*")
		if inside_surround then
			vim.cmd("normal gsd*.")
		else
			vim.cmd("normal viw")
			vim.cmd("normal 2gsa*")
		end
		vim.notify("Bolded current word", vim.log.levels.INFO)
	end
end, { desc = "[P]BOLD toggle bold markers" })

-- Crate task or checkbox lamw26wmal
-- These are marked with <leader>x using bullets.vim
-- I used <C-l> before, but that is used for pane navigation
vim.keymap.set({ "n", "i" }, "<M-l>", function()
	-- Get the current line/row/column
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row, _ = cursor_pos[1], cursor_pos[2]
	local line = vim.api.nvim_get_current_line()
	-- 1) If line is empty => replace it with "- [ ] " and set cursor after the brackets
	if line:match("^%s*$") then
		local final_line = "- [ ] "
		vim.api.nvim_set_current_line(final_line)
		-- "- [ ] " is 6 characters, so cursor col = 6 places you *after* that space
		vim.api.nvim_win_set_cursor(0, { row, 6 })
		return
	end
	-- 2) Check if line already has a bullet with possible indentation: e.g. "  - Something"
	--    We'll capture "  -" (including trailing spaces) as `bullet` plus the rest as `text`.
	local bullet, text = line:match("^([%s]*[-*]%s+)(.*)$")
	if bullet then
		-- Convert bullet => bullet .. "[ ] " .. text
		local final_line = bullet .. "[ ] " .. text
		vim.api.nvim_set_current_line(final_line)
		-- Place the cursor right after "[ ] "
		-- bullet length + "[ ] " is bullet_len + 4 characters,
		-- but bullet has trailing spaces, so #bullet includes those.
		local bullet_len = #bullet
		-- We want to land after the brackets (four characters: `[ ] `),
		-- so col = bullet_len + 4 (0-based).
		vim.api.nvim_win_set_cursor(0, { row, bullet_len + 4 })
		return
	end
	-- 3) If there's text, but no bullet => prepend "- [ ] "
	--    and place cursor after the brackets
	local final_line = "- [ ] " .. line
	vim.api.nvim_set_current_line(final_line)
	-- "- [ ] " is 6 characters
	vim.api.nvim_win_set_cursor(0, { row, 6 })
end, { desc = "Convert bullet to a task or insert new task bullet" })

-- Paste a github link and add it in this format
-- [folke/noice.nvim](https://github.com/folke/noice.nvim)
-- Semicolon keymap is a bit weird on mac norwegian layout, so I use <M-ø> and
-- <M-æ> for pasting github links in different formats
vim.keymap.set({ "n", "v", "i" }, "<M-ø>", function()
	-- Insert the text in the desired format
	vim.cmd("normal! a[]() ")
	vim.cmd("normal! F(pv2F/lyF[p")
	-- Leave me in normal mode or command mode
	vim.cmd("stopinsert")
end, { desc = "[P]Paste Github link" })
--
-- Paste a github link and add it in this format
-- [folke/noice.nvim](https://github.com/folke/noice.nvim){:target="\_blank"}
-- Semicolon keymap is a bit weird on mac norwegian layout, so I use <M-ø> and
-- <M-æ> for pasting github links in different formats
vim.keymap.set({ "n", "v", "i" }, "<M-æ>", function()
	-- Insert the text in the desired format
	vim.cmd('normal! a[](){:target="_blank"} ')
	vim.cmd("normal! F(pv2F/lyF[p")
	-- Leave me in normal mode or command mode
	vim.cmd("stopinsert")
end, { desc = "[P]Paste Github link" })

local function get_markdown_headings()
	local cursor_line = vim.fn.line(".")
	local parser = vim.treesitter.get_parser(0, "markdown")
	if not parser then
		vim.notify("Markdown parser not available", vim.log.levels.ERROR)
		return nil, nil, nil, nil, nil, nil
	end
	local tree = parser:parse()[1]
	local query = vim.treesitter.query.parse(
		"markdown",
		[[
    (atx_heading (atx_h1_marker) @h1)
    (atx_heading (atx_h2_marker) @h2)
    (atx_heading (atx_h3_marker) @h3)
    (atx_heading (atx_h4_marker) @h4)
    (atx_heading (atx_h5_marker) @h5)
    (atx_heading (atx_h6_marker) @h6)
  ]]
	)
	-- Collect and sort all headings
	local headings = {}
	for id, node in query:iter_captures(tree:root(), 0) do
		local start_line = node:start() + 1 -- Convert to 1-based
		table.insert(headings, { line = start_line, level = id })
	end
	table.sort(headings, function(a, b)
		return a.line < b.line
	end)
	-- Find current heading and track its index
	local current_heading, current_idx, next_heading, next_same_heading
	for idx, h in ipairs(headings) do
		if h.line <= cursor_line then
			current_heading = h
			current_idx = idx
		elseif not next_heading then
			next_heading = h -- First heading after cursor
		end
	end
	-- Find next same-level heading if current exists
	if current_heading then
		-- Look for next same-level after current index
		for i = current_idx + 1, #headings do
			local h = headings[i]
			if h.level == current_heading.level then
				next_same_heading = h
				break
			end
		end
	end
	-- Return all values (nil if not found)
	return current_heading and current_heading.line or nil,
		current_heading and current_heading.level or nil,
		next_heading and next_heading.line or nil,
		next_heading and next_heading.level or nil,
		next_same_heading and next_same_heading.line or nil,
		next_same_heading and next_same_heading.level or nil
end

-- Print details of current markdown heading, next heading and next same level heading
vim.keymap.set("n", "<leader>mT", function()
	local cl, clvl, nl, nlvl, nsl, nslvl = get_markdown_headings()
	local message_parts = {}
	if cl then
		table.insert(message_parts, string.format("Current: H%d (line %d)", clvl, cl))
	else
		table.insert(message_parts, "Not in a section")
	end
	if nl then
		table.insert(message_parts, string.format("Next: H%d (line %d)", nlvl, nl))
	end
	if nsl then
		table.insert(message_parts, string.format("Next H%d: line %d", nslvl, nsl))
	end
	vim.notify(table.concat(message_parts, " | "), vim.log.levels.INFO)
end, { desc = "Show current, next, and same-level Markdown headings" })

-- Detect todos and toggle between ":" and ";", or show a message if not found
-- This is to "mark them as done"
vim.keymap.set("n", "<leader>td", function()
	-- Get the current line
	local current_line = vim.fn.getline(".")
	-- Get the current line number
	local line_number = vim.fn.line(".")
	if string.find(current_line, "TODO:") then
		-- Replace the first occurrence of ":" with ";"
		local new_line = current_line:gsub("TODO:", "TODO;")
		-- Set the modified line
		vim.fn.setline(line_number, new_line)
	elseif string.find(current_line, "TODO;") then
		-- Replace the first occurrence of ";" with ":"
		local new_line = current_line:gsub("TODO;", "TODO:")
		-- Set the modified line
		vim.fn.setline(line_number, new_line)
	else
		vim.cmd("echo 'todo item not detected'")
	end
end, { desc = "[P]TODO toggle item done or not" })

-- HACK: Create table of contents in neovim with markdown-toc
-- https://youtu.be/BVyrXsZ_ViA
--
-- Generate/update a Markdown TOC
-- To generate the TOC I use the markdown-toc plugin
-- https://github.com/jonschlinkert/markdown-toc
-- And the markdown-toc plugin installed as a LazyExtra
-- Function to update the Markdown TOC with customizable headings
local function update_markdown_toc(heading2, heading3)
	local path = vim.fn.expand("%") -- Expands the current file name to a full path
	local bufnr = 0 -- The current buffer number, 0 references the current active buffer
	-- Save the current view
	-- If I don't do this, my folds are lost when I run this keymap
	vim.cmd("mkview")
	-- Retrieves all lines from the current buffer
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local toc_exists = false -- Flag to check if TOC marker exists
	local frontmatter_end = 0 -- To store the end line number of frontmatter
	-- Check for frontmatter and TOC marker
	for i, line in ipairs(lines) do
		if i == 1 and line:match("^---$") then
			-- Frontmatter start detected, now find the end
			for j = i + 1, #lines do
				if lines[j]:match("^---$") then
					frontmatter_end = j
					break
				end
			end
		end
		-- Checks for the TOC marker
		if line:match("^%s*<!%-%-%s*toc%s*%-%->%s*$") then
			toc_exists = true
			break
		end
	end
	-- Inserts H2 and H3 headings and <!-- toc --> at the appropriate position
	if not toc_exists then
		local insertion_line = 1 -- Default insertion point after first line
		if frontmatter_end > 0 then
			-- Find H1 after frontmatter
			for i = frontmatter_end + 1, #lines do
				if lines[i]:match("^#%s+") then
					insertion_line = i + 1
					break
				end
			end
		else
			-- Find H1 from the beginning
			for i, line in ipairs(lines) do
				if line:match("^#%s+") then
					insertion_line = i + 1
					break
				end
			end
		end
		-- Insert the specified headings and <!-- toc --> without blank lines
		-- Insert the TOC inside a H2 and H3 heading right below the main H1 at the top lamw25wmal
		vim.api.nvim_buf_set_lines(bufnr, insertion_line, insertion_line, false, { heading2, heading3, "<!-- toc -->" })
	end
	-- Silently save the file, in case TOC is being created for the first time
	vim.cmd("silent write")
	-- Silently run markdown-toc to update the TOC without displaying command output
	-- vim.fn.system("markdown-toc -i " .. path)
	-- I want my bulletpoints to be created only as "-" so passing that option as
	-- an argument according to the docs
	-- https://github.com/jonschlinkert/markdown-toc?tab=readme-ov-file#optionsbullets
	vim.fn.system('markdown-toc --bullets "-" -i ' .. path)
	vim.cmd("edit!") -- Reloads the file to reflect the changes made by markdown-toc
	vim.cmd("silent write") -- Silently save the file
	vim.notify("TOC updated and file saved", vim.log.levels.INFO)
	-- -- In case a cleanup is needed, leaving this old code here as a reference
	-- -- I used this code before I implemented the frontmatter check
	-- -- Moves the cursor to the top of the file
	-- vim.api.nvim_win_set_cursor(bufnr, { 1, 0 })
	-- -- Deletes leading blank lines from the top of the file
	-- while true do
	--   -- Retrieves the first line of the buffer
	--   local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
	--   -- Checks if the line is empty
	--   if line == "" then
	--     -- Deletes the line if it's empty
	--     vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, {})
	--   else
	--     -- Breaks the loop if the line is not empty, indicating content or TOC marker
	--     break
	--   end
	-- end
	-- Restore the saved view (including folds)
	vim.cmd("loadview")
end

-- HACK: Create table of contents in neovim with markdown-toc
-- https://youtu.be/BVyrXsZ_ViA
--
-- Keymap for English TOC
vim.keymap.set("n", "<leader>mtt", function()
	update_markdown_toc("## Contents", "### Table of contents")
end, { desc = "[P]Insert/update Markdown TOC (English)" })

-- HACK: Create table of contents in neovim with markdown-toc
-- https://youtu.be/BVyrXsZ_ViA
--
-- Keymap for Spanish TOC lamw25wmal
vim.keymap.set("n", "<leader>mtn", function()
	update_markdown_toc("## Innhold", "### Innholdsfortegnelse")
end, { desc = "[P]Insert/update Markdown TOC (Norwegian)" })

-- Save the cursor position globally to access it across different mappings
_G.saved_positions = {}

-- Mapping to jump to the first line of the TOC
vim.keymap.set("n", "<leader>mm", function()
	-- Save the current cursor position
	_G.saved_positions["toc_return"] = vim.api.nvim_win_get_cursor(0)
	-- Perform a silent search for the <!-- toc --> marker and move the cursor two lines below it
	vim.cmd("silent! /<!-- toc -->\\n\\n\\zs.*")
	-- Clear the search highlight without showing the "search hit BOTTOM, continuing at TOP" message
	vim.cmd("nohlsearch")
	-- Retrieve the current cursor position (after moving to the TOC)
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1]
	-- local col = cursor_pos[2]
	-- Move the cursor to column 15 (starts counting at 0)
	-- I like just going down on the TOC and press gd to go to a section
	vim.api.nvim_win_set_cursor(0, { row, 14 })
end, { desc = "[P]Jump to the first line of the TOC" })

-- Mapping to return to the previously saved cursor position
vim.keymap.set("n", "<leader>mn", function()
	local pos = _G.saved_positions["toc_return"]
	if pos then
		vim.api.nvim_win_set_cursor(0, pos)
	end
end, { desc = "[P]Return to position before jumping" })

-- Search UP for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1
-- heading at the very top of the file
-- This will only search for H2 headings and above
-- hardtime.nvim causes issues with this key, you have to unrestrict it in the
-- plugin config
vim.keymap.set({ "n", "v" }, "gk", function()
	-- `?` - Start a search backwards from the current cursor position.
	-- `^` - Match the beginning of a line.
	-- `##` - Match 2 ## symbols
	-- `\\+` - Match one or more occurrences of prev element (#)
	-- `\\s` - Match exactly one whitespace character following the hashes
	-- `.*` - Match any characters (except newline) following the space
	-- vim.cmd("silent! ?^##\\+\\s.*$")
	local ft = vim.bo.filetype
	if ft == "typst" then
		vim.cmd("silent! ?^==\\+\\s.*$")
		-- Clear the search highlight
		vim.cmd("nohlsearch")
		return
	end -- `$` - Match extends to end of line
	vim.cmd("silent! ?^##\\+\\s.*$")
	-- Clear the search highlight
	vim.cmd("nohlsearch")
end, { desc = "[P]Go to previous markdown header" })

-- HACK: Jump between markdown headings in lazyvim
-- https://youtu.be/9S7Zli9hzTE
--
-- Search DOWN for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1
-- heading at the very top of the file
-- This will only search for H2 headings and above
-- hardtime.nvim causes issues with this key, you have to unrestrict it in the
-- plugin config
vim.keymap.set({ "n", "v" }, "gj", function()
	-- `/` - Start a search forwards from the current cursor position.
	-- `^` - Match the beginning of a line.
	-- `##` - Match 2 ## symbols
	-- `\\+` - Match one or more occurrences of prev element (#)
	-- `\\s` - Match exactly one whitespace character following the hashes
	-- `.*` - Match any characters (except newline) following the space
	-- `$` - Match extends to end of line
	local ft = vim.bo.filetype
	if ft == "typst" then
		vim.cmd("silent! /^==\\+\\s.*$")
		-- Clear the search highlight
		vim.cmd("nohlsearch")
		return
	end
	vim.cmd("silent! /^##\\+\\s.*$")
	-- Clear the search highlight
	vim.cmd("nohlsearch")
end, { desc = "[P]Go to next markdown header" })

-- Function to delete the current file with confirmation
local function delete_current_file()
	local current_file = vim.fn.expand("%:p")
	if current_file and current_file ~= "" then
		-- Check if trash utility is installed
		if vim.fn.executable("trash") == 0 then
			vim.api.nvim_echo({
				{ "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
				{ "- In macOS run `brew install trash`\n", nil },
			}, false, {})
			return
		end
		-- Prompt for confirmation before deleting the file
		vim.ui.input({
			prompt = "Type 'del' to delete the file '" .. current_file .. "': ",
		}, function(input)
			if input == "del" then
				-- Delete the file using trash app
				local success, _ = pcall(function()
					vim.fn.system({ "trash", vim.fn.fnameescape(current_file) })
				end)
				if success then
					vim.api.nvim_echo({
						{ "File deleted from disk:\n", "Normal" },
						{ current_file, "Normal" },
					}, false, {})
					-- Close the buffer after deleting the file
					vim.cmd("bd!")
				else
					vim.api.nvim_echo({
						{ "Failed to delete file:\n", "ErrorMsg" },
						{ current_file, "ErrorMsg" },
					}, false, {})
				end
			else
				vim.api.nvim_echo({
					{ "File deletion canceled.", "Normal" },
				}, false, {})
			end
		end)
	else
		vim.api.nvim_echo({
			{ "No file to delete", "WarningMsg" },
		}, false, {})
	end
end

-- Keymap to delete the current file
vim.keymap.set("n", "<leader>fD", function()
	delete_current_file()
end, { desc = "[P]Delete current file" })

-- - I have several `.md` documents that do not follow markdown guidelines
-- - There are some old ones that have more than one H1 heading in them, so when I
--   open one of those old documents, I want to add one more `#` to each heading
--
--  This doesn't ask for confirmation and just increase all the headings
vim.keymap.set("n", "<leader>mhI", function()
	-- Save the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- I'm using [[ ]] to escape the special characters in a command
	vim.cmd([[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/]])
	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	-- Clear search highlight
	vim.cmd("nohlsearch")
end, { desc = "[P]Increase headings without confirmation" })

vim.keymap.set("n", "<leader>mhD", function()
	-- Save the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- I'm using [[ ]] to escape the special characters in a command
	vim.cmd([[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/]])
	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	-- Clear search highlight
	vim.cmd("nohlsearch")
end, { desc = "[P]Decrease headings without confirmation" })

-- Increase markdown headings for text selected in visual mode
vim.keymap.set("v", "<leader>mhI", function()
	-- Save cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- Get visual selection bounds and ensure correct order
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	local buf = vim.api.nvim_get_current_buf()
	-- Process each line in the selection
	for lnum = start_line, end_line do
		local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
		if line and line:match("^##+%s") then -- Match headings level 2+
			local new_line = "#" .. line
			vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { new_line })
		end
	end
	-- Restore cursor and clear highlights
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	vim.cmd("nohlsearch")
end, { desc = "Increase headings in visual selection" })

-- Decrease markdown headings for text selected in visual mode
vim.keymap.set("v", "<leader>mhD", function()
	-- Save cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	-- Get visual selection bounds and ensure correct order
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	local buf = vim.api.nvim_get_current_buf()
	-- Process each line in the selection
	for lnum = start_line, end_line do
		local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
		if line and line:match("^##+%s") then -- Match headings level 2+
			-- Split into hashes and content, then remove one #
			local hashes, content = line:match("^(#+)(%s.+)$")
			if hashes and #hashes >= 2 then
				local new_hashes = hashes:sub(1, #hashes - 1)
				local new_line = new_hashes .. content
				vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { new_line })
			end
		end
	end
	-- Restore cursor and clear highlights
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	vim.cmd("nohlsearch")
end, { desc = "Decrease headings in visual selection" })

-- =============================================================================
-- End Markdown Section
-- =============================================================================
