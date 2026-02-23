vim.opt.termguicolors = true

require("gianluca.remap")
require("gianluca.set")
require("gianluca.lazy")

require("catppuccin").setup({
    transparent_background = true,
})
vim.cmd.colorscheme("catppuccin-mocha")
