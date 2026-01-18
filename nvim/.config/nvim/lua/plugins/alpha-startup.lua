return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local theta = require("alpha.themes.theta")
    local dashboard = require("alpha.themes.dashboard")

    theta.buttons.val = {
      dashboard.button("e", "  New file", ":ene <CR>"),
      dashboard.button("SPC f f", "󰈞  Find file"),
      dashboard.button("SPC f g", "󰊄  Live grep"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
      dashboard.button("q", "󰅚  Quit", ":qa <CR>"),
    }

    alpha.setup(theta.config)
  end,
}
