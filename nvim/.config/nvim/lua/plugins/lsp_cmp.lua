return {
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Basic snippet config
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),

          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- lsp + mason
  {
    -- We drive everything from mason-lspconfig now
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim" }, -- LSP installer
      "neovim/nvim-lspconfig",    -- provides the actual server configs
      "hrsh7th/cmp-nvim-lsp",     -- for completion capabilities
    },
    config = function()
      -- 1. Mason core
      require("mason").setup()

      -- 2. Mason-lspconfig: install + auto-enable servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
        },
        automatic_enable = true
      })

      -- 3. Capabilities for nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 4. Configure each server with vim.lsp.config (new API)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("gdscript", {
        capabilities = capabilities,
      })
      vim.lsp.enable("gdscript")

      -- 5. LSP keymaps using LspAttach (recommended)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr, noremap = true, silent = true }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
