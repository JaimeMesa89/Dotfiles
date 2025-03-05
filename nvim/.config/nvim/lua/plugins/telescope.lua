return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      pickers = {
	find_files = {
	  -- theme = "ivy"
	}
      },
      extensions = {
	fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<space>fs", function()
      require('telescope.builtin').find_files {
	cwd = vim.fn.stdpath("config")
      }
    end)
    -- Recommended additional shortcuts
    -- Live grep search across your project
    vim.keymap.set("n", "<space>lg", require('telescope.builtin').live_grep)
    -- List open buffers
    vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers)
    -- Recently opened files
    vim.keymap.set("n", "<space>fo", require('telescope.builtin').oldfiles)
    -- Find files in a git repository
    vim.keymap.set("n", "<space>gf", require('telescope.builtin').git_files)
    -- Browse git commits
    vim.keymap.set("n", "<space>gc", require('telescope.builtin').git_commits)
    -- List git branches
    vim.keymap.set("n", "<space>gb", require('telescope.builtin').git_branches)
    -- View registers
    vim.keymap.set("n", "<space>fr", require('telescope.builtin').registers)
    -- Jump to marks
    vim.keymap.set("n", "<space>m",  require('telescope.builtin').marks)

    -- If using LSP
    -- Document symbols
    vim.keymap.set("n", "<space>ds", require('telescope.builtin').lsp_document_symbols)
    -- Workspace symbols
    -- vim.keymap.set("n", "<space>ws", require('telescope.builtin').lsp_workspace_symbols)
    vim.keymap.set("n", "<space>lr", require('telescope.builtin').lsp_references)
  end
}
