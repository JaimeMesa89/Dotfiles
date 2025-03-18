-- Tab size
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Leader Key
vim.g.mapleader = " "

vim.g.mkdp_browser = "firefox"  -- Replace with your browser (e.g., "chrome", "brave", "edge")

-- Set row number and relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Shortcuts
-- Oil
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
-- Split view vertical
vim.keymap.set("n", "<space>v", "<cmd>vnew<CR>")
-- Split view horizontal
vim.keymap.set("n", "<space>h", "<cmd>new<CR>")
-- Create new tab
vim.keymap.set("n", "<space>t", "<cmd>tabnew<CR>")
-- Save
vim.keymap.set("n", "<space>w", "<cmd>w<CR>")
-- Quit
vim.keymap.set("n", "<space>q", "<cmd>q<CR>")
-- Save and quit
vim.keymap.set("n", "<space>x", "<cmd>x<CR>")
-- Exit terminal in terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
-- Format/Indent text
vim.keymap.set("n", "<space>i", function() vim.lsp.buf.format() end)

-- Theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Terminal
-- Remove row number on terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

-- Create bottom terminal
vim.keymap.set("n", "<space>b", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5)
end)
