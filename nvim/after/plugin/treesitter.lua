local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

configs.setup({
  ensure_installed = { "lua", "javascript", "typescript", "tsx", "json", "html", "css", "bash" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
