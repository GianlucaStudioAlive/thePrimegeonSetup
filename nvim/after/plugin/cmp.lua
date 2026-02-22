local cmp = require("cmp")

cmp.setup({
  preselect = cmp.PreselectMode.None,

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    -- CR: conferma se visibile, altrimenti newline normale
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = false })
      else
        fallback()
      end
    end, { "i", "s" }),

    -- TAB: naviga nel menu se aperto, altrimenti TAB normale
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-e>"] = cmp.mapping.abort(),
  }),

  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
})
