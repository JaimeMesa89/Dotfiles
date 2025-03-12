vim.diagnostic.config({
	signs = {
		severity = { min = vim.diagnostic.severity.WARN }, -- Show signs only for warnings and errors
	},
	virtual_text = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	float = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	-- signs can be left as-is or adjusted similarly if needed
})
