return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,  -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        local wk = require("which-key")
        wk.register({
          h = {
            name = "Git Hunk",
            s = {
              function()
                gs.stage_hunk()
                gs.toggle_signs()
              end,
              "Stage Hunk",
            },
            r = { gs.reset_hunk, "Reset Hunk" },
            S = { gs.stage_buffer, "Stage Buffer" },
            u = { gs.undo_stage_hunk, "Undo Stage Hunk" },
            R = { gs.reset_buffer, "Reset Buffer" },
            p = { gs.preview_hunk, "Preview Hunk" },
            b = {
              function()
                gs.blame_line({ full = true })
                gs.toggle_current_line_blame()
              end,
              "Blame Line",
            },
            d = { gs.diffthis, "Diff this" },
            D = {
              function()
                gs.diffthis("~")
              end,
              "Diff this ~",
            },
          },
        }, { prefix = "<leader>" })
        wk.register({
          h = {
            name = "Git Hunk",
            s = {
              function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end,
              "Stage Hunk",
            },
            r = {
              function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end,
              "Reset Hunk",
            },
          },
        }, { prefix = "<leader>", mode = "v" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
