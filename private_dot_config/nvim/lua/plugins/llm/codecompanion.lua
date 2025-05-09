return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"ravitemer/mcphub.nvim",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "ollama",
				},
				inline = {
					adapter = "ollama",
				},
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "cmd:kwallet-query 'Default keyring' -f 'Ollama' -r 'API_url'",
							api_key = "cmd:kwallet-query 'Default keyring' -f 'Ollama' -r 'API_key'",
						},
						headers = {
							["Content-Type"] = "application/json",
							["Authorization"] = "Bearer ${api_key}",
						},
						parameters = {
							sync = true,
						},
						schema = {
							model = {
								default = "qwen2.5-coder",
							},
						},
					})
				end,
			},
		})
	end,
}
