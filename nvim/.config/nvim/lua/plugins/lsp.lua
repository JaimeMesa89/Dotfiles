return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'saghen/blink.cmp',
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					{
						path = "${3rd}/luv/library",
						words = { "vim%.uv" }
					},
				},
			},
		},
		{
			"S1M0N38/love2d.nvim", -- Ensure the Love2D plugin is installed
			ft = "lua",   -- Only load it for Lua files
			config = function()
				require("love2d").setup({
					library = {
						-- path = vim.fn.expand("~/.config/nvim/lua/config/apis/love_api.lua")
						vim.fn.expand("~/.local/share/nvim/site/pack/packer/start/love2d.nvim/lua/love2d/love_api.lua")
					}
				})
			end,
		},
	},

	-- example using `opts` for defining servers
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT', -- Neovim and Love2D use LuaJIT
						},
						diagnostics = {
							globals = { 'vim', 'love' }, -- Add `love` and `vim` as recognized globals
							disable = { 'unused-local', 'lowercase-global', 'trailing-space' },
						},
						workspace = {
							-- library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
							library = vim.tbl_extend("force",
								vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
								{ require('love2d').library } -- Add Love2D API path here
							),
							checkThirdParty = false, -- Disable third-party check prompt
						},
						telemetry = {
							enable = false, -- Disable telemetry
						},
					},
				},
			}
		}
	},
	config = function(_, opts)
		local lspconfig = require('lspconfig')
		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end
}
