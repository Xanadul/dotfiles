return {
  {
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    opts = {render_modes = {'n', 'c', 't'}},
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons',
      {
        "https://github.com/vimwiki/vimwiki",
      },
      {
        "https://github.com/epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
    },
    config = function()
      -- Add vimwiki to the file_types config
      require('render-markdown').setup({
        file_types = { 'markdown', 'vimwiki' },
      })
      -- Register markdown as the parser for vimwiki files
      vim.treesitter.language.register('markdown', 'vimwiki')
      -- Disable Obsidians markdown rendering
      -- require('obsidian').setup({
      --   ui = { enable = false },
      --   workspaces = {
      --     {
      --       name = "personal",
      --       path = "~/Git/quartz/content/"
      --       -- path = "~/Notes/"
      --     }
      --   }
      -- })
    end
  },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
        -- You can choose one of the following pickers
        'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        -- 'echasnovski/mini.pick',
    },
  },

}
