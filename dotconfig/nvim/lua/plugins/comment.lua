return {
  -- Comments line using "gcc", block comment "gbc"
  -- Can also do gco, gcO, gcA, gcw, gc$, ..Can also do gco, gcO, gcA, gcw, gc$, ....
  "numToStr/Comment.nvim",
  opts = {
  },
  config = function ()
    require('Comment').setup()
  end 
}
