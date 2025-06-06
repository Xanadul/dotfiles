return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { 'org' },
  config = function ()
    require('orgmode').setup({
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    })

  require('nvim-treesitter.configs').setup({
      -- ensure_installed = 'all',
      ignore_install = { 'org' },
    })
  end,
}
