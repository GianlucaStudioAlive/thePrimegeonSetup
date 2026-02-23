vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
-- Autosave after 300ms of inactivity (like VSCode)
vim.o.updatetime = 300

local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
  group = autosave_group,
  callback = function()
    -- Ignora buffer speciali (Telescope, netrw, prompt, ecc.)
    if vim.bo.buftype ~= "" then return end
    if vim.bo.modified then
      vim.defer_fn(function()
        if vim.bo.modified and vim.bo.buftype == "" then
          vim.cmd("silent update")
        end
      end, 300)
    end
  end,
})
