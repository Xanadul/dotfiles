return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    disabled_keys = {
      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
    },
    restricted_keys = {
      ["<Up>"] = {"", "x"},
      ["<Down>"] = {"", "x"},
      ["<Left>"] = {"", "x"},
      ["<Right>"] = {"", "x"},
    },
  },
}
