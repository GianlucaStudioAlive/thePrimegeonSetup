-- Neovim 0.11+ native LSP config for emmet-ls (no nvim-lspconfig)

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp.default_capabilities(capabilities)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
  callback = function(args)
    vim.lsp.start({
      name = "emmet-ls",
      cmd = { "emmet-ls", "--stdio" },
      root_dir = vim.fs.root(args.file, { "package.json", ".git" }) or vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})
