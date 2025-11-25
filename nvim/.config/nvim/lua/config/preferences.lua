local opt = vim.opt

-- UI
opt.number = true         -- Absolute line number on current line
opt.relativenumber = true -- Relative line number on all other lines
opt.cursorline = true     -- Highlights the line the cursor is on
opt.showmode = false      -- Disable mode displaying
opt.signcolumn = "yes"    -- Always show sign colum (LSP errors/warning, breakpoints, git)
opt.termguicolors = true  -- Enables true 24-bit color in the terminal

-- Tabs / Indent
opt.expandtab = true   -- Converts the tabs in spaces automatically
opt.shiftwidth = 2     -- Number of spaces inserted when indenting (<<, >>, autoindent)
opt.tabstop = 2        -- How many spaces a tab is
opt.smartindent = true -- Enable smartinent

-- Search
opt.ignorecase = true -- Searches become case-insensitive by default
opt.smartcase = true  -- If the search contains any upper letter, the search become case-sensitive
opt.incsearch = true  -- Show results while typing
opt.hlsearch = true   -- Hightlights all matches of last search

-- Splits
opt.splitbelow = true -- When creating a horizontal split it open below
opt.splitright = true -- When creating a vertical split it opens to the right

-- Misc
opt.mouse = "a"               -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard by default
opt.swapfile = false          -- Disables the creation of swap files
opt.undofile = true           -- Enable persistent undo history
opt.wrap = false              -- Disable line wrapping
opt.scrolloff = 5             -- Number of padding lines when scrolling

-- Godot
-- Add this to godot external editor exec flags --server ./godothost --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"
local projectfile = vim.fn.getcwd() .. "/project.godot"

if vim.loop.fs_stat(projectfile) then
  vim.fn.serverstart("./godothost")
end
