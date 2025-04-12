return {
  "ziontee113/color-picker.nvim",
  config = function()
    require("color-picker").setup({
      ["icons"] = { "█", "" },
      ["keymap"] = {
        ["<Left>"] = "<Plug>ColorPickerSlider5Decrease",
        ["<Right>"] = "<Plug>ColorPickerSlider5Increase",
      },
    });
    require('which-key').add {
      { '<leader>ic', "<CMD>PickColor<CR>",       desc = 'Pick Color',        mode = 'n' },
      { '<leader>ia', "<CMD>PickColorInsert<CR>", desc = 'Pick Color Insert', mode = 'n' },
    }
  end,
}
