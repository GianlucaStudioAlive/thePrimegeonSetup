-- Native TS/JS LSP (Neovim 0.11+) via typescript-language-server

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp.default_capabilities(capabilities)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function(args)
    vim.lsp.start({
      name = "tsserver",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = vim.fs.root(args.file, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }) or vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})
