return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
        },
      })

      -- Load fzf extension if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
