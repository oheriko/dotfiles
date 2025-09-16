local function find_biome_cmd()
	local local_biome = vim.fn.getcwd() .. "/node_modules/.bin/biome"

	if vim.fn.executable(local_biome) == 1 then
		return { local_biome, "lsp-proxy" }
	end

	if vim.fn.executable("biome") == 1 then
		return { "biome", "lsp-proxy" }
	end

	return nil
end

return {
	name = "biome",
	cmd = find_biome_cmd(),
	filetypes = {
		"astro",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
	},
	root_markers = { "biome.json", "biome.jsonc" },
}
