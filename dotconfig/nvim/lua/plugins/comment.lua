return {
  -- Comments line using "gcc", block comment "gbc"
  -- Can also do gco, gcO, gcA, gcw, gc$, ..Can also do gco, gcO, gcA, gcw, gc$, ....
  -- Replaceable with Mini.comment, which doesn't fully work with some languages yet (eg. Hyprlang)
  "numToStr/Comment.nvim",
  opts = {
  },
  config = function ()
    require('Comment').setup()
  end
}
