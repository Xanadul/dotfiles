return {
--  diff is not working...
--  'jiaoshijie/undotree',
--  dependencies = 'nvim-lua/plenary.nvim',
--  config = true, 
--  keys = { -- load the plugin only when using it's keybinding:
--    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
--  },
  'mbbill/undotree',
	config= function()
		vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = '[T]oggle [U]ndotree ' })
	end
}
