return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }


    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Trim Whitespaces with :lua MiniTrailspace.trim()
    require('mini.trailspace').setup()
    require('which-key').add {
      { '<leader>ew', "<cmd>lua MiniTrailspace.trim()<cr>", desc = '[W]hitespaces remove', mode = 'n' },
    }

    -- Use ga (or gA for preview) to start align mode.
    -- modifier presets: =  ,  |   space
    -- Press s to enter split Lua pattern.
    -- Press j to choose justification side from available ones ("left", "center", "right", "none").
    -- Press m to enter merge delimiter.
    -- Press f to enter filter Lua expression to configure which parts will be affected (like "align only first column").
    -- Press i to ignore some commonly unwanted split matches.
    -- Press p to pair neighboring parts so they be aligned together.
    -- Press t to trim whitespace from parts.
    -- Press <BS> (backspace) to delete some last pre-step.
    require('mini.align').setup()

    -- toggle comments, eg.: gcc   gca{
    -- Alternative to comment.lua
    -- require('mini.comment').setup()


    -- highlight word under cursor in Buffer
    require('mini.cursorword').setup()



    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
