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
	end,
  vim.keymap.set("n", "<leader>ic", "<CMD>PickColor<CR>", {}),
  vim.keymap.set("n", "<leader>ia", "<CMD>PickColorInsert<CR>", {}),
}
