vim.opt.termguicolors = true

require("gianluca.set")
require("gianluca.remap")
require("gianluca.lazy")

require("catppuccin").setup({
    transparent_background = true,
})
vim.cmd.colorscheme("catppuccin-mocha")
