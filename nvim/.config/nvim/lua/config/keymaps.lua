-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { silent = true }

-- Better window movement
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Exit terminal mode
map("t", "<ESC>", "<C-\\><C-n>", opts)

-- Save / quit
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>x", "<cmd>x<CR>", opts)

-- Tabs
map("n", "<leader>t", "<cmd>tabnew<CR>", opts)

-- Splits
map("n", "<leader>h", "<cmd>split<CR>", opts)
map("n", "<leader>v", "<cmd>vsplit<CR>", opts)

-- Formatting
map("n", "<leader>i", vim.lsp.buf.format, opts)

-- Diagnostics
map("n", "<leader>dd", vim.diagnostic.open_float, opts) -- Show diagnostics for the current line
map("n", "[d", vim.diagnostic.goto_prev, opts)          -- Jump to previous diagnostic
map("n", "]d", vim.diagnostic.goto_next, opts)          -- Jump to next diagnostic

-- LSP-specific keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufopts = { buffer = bufnr, silent = true, noremap = true }

    -- LSP navigation
    map("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to definition
    map("n", "K", vim.lsp.buf.hover, bufopts)       -- Show documentation
    map("n", "gr", vim.lsp.buf.references, bufopts) -- Find references

    -- LSP actions
    map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

    -----------------------------------------------------------------------
    -- Godot-specific find_files override
    -----------------------------------------------------------------------
    if client and client.name == "gdscript" then
      map("n", "<leader>ff", function()
        require("telescope.builtin").find_files({
          prompt_title = "Godot Scripts",
          find_command = {
            "rg",
            "--files",
            "-g", "*.gd",
            "-g", "*.gdshader",
            "-g", "*.shader",
            "--hidden",
            "--follow",
          },
        })
      end, { buffer = bufnr, desc = "Find Godot scripts" })
    end
  end,
})

-- Plugins
-- Oil File Manger
map("n", "-", "<cmd>Oil<CR>", opts) -- Open oils menu

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Toggleterm Terminal
map("n", "<C-f>", "<cmd>ToggleTerm direction=float<cr>", opts)              -- Open float terminal
map("n", "<C-b>", "<cmd>ToggleTerm direction=horizontal size=12<cr>", opts) -- Open bottom terminal
