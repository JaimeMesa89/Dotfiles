return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-f>]],
        shade_terminals = true,
        direction = "float",
      })
    end,
  },
}
