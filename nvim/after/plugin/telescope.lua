local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
  },
})

-- Trova file
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

-- Trova file git
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

-- Grep con input manuale
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Live grep (ricerca in tempo reale)
vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})

-- Grep parola sotto cursore
vim.keymap.set("n", "<leader>pw", builtin.grep_string, {})
