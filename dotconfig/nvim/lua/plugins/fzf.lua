return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    FzfLua = require("fzf-lua")
    local wk = require("which-key")

    local function ast_grep()
      -- Usage: Type ast-grep search pattern
      -- eg.: $A == false
      -- Dependency: ast-grep (not called sg, on arch sg is something else)
      local query = vim.fn.input("ast-grep query: ", "")
      FzfLua.fzf_exec(
        "ast-grep --context 0 --heading never --pattern '" .. query .. "' ",
        {
          exec_empty_query = false,
          actions = {
            ["default"] = FzfLua.actions.file_edit,
          },
          previewer = 'builtin'
        }
      )
    end

    wk.add({
      { "<leader>bb",  function() FzfLua.buffers() end,                       desc = '[B]uffer' },
      { "<leader>cci", function() FzfLua.lsp_incoming_calls() end,            desc = "[I]ncoming" },
      { "<leader>cco", function() FzfLua.lsp_outgoing_calls() end,            desc = "[O]utgoing" },
      { "<leader>cd",  function() FzfLua.lsp_definitions() end,               desc = "[D]efinitions" },
      { "<leader>ci",  function() FzfLua.lsp_implementations() end,           desc = "[I]mplementations" },
      { "<leader>cr",  function() FzfLua.lsp_references() end,                desc = "[R]eferences" },
      { "<leader>cs",  function() FzfLua.lsp_document_symbols() end,          desc = "[S]ymbols" },
      { '<leader>ws',  function() FzfLua.lsp_dynamic_workspace_symbols() end, desc = '[W]orkspace [S]ymbols' },
      { '<leader>D',   function() FzfLua.lsp_typedefs() end,                  desc = 'Type [D]efinition' },
      { '<leader>gj',  function() FzfLua.jumps() end,                         desc = '[J]umplist' },
      { '<leader>to',  function() FzfLua.nvim_options() end,                  desc = 'Vim [O]ptions' },
      { '<leader>p',   function() FzfLua.registers() end,                     desc = '[P]aste Register' },
      --
      -- -- Find stuff
      { "<leader>fb",  function() FzfLua.buffers() end,                       desc = '[B]uffer' },
      { '<leader>ff',  function() FzfLua.files({}) end,                       desc = '[F]ile',               mode = 'n' },
      { "<leader>fc",  function() FzfLua.commands() end,                      desc = "[C]ommand" },
      { "<leader>fg",  function() FzfLua.live_grep_native() end,              desc = "[G]rep" },
      { "<leader>fa",  function() ast_grep() end,                             desc = "[A]ST-Grep" },
      { '<leader>fw',  function() FzfLua.grep_cword() end,                    desc = 'current [W]ord' },
      { '<leader>fW',  function() FzfLua.grep_cWORD() end,                    desc = 'current [W]ORD' },
      { '<leader>fd',  function() FzfLua.diagnostics_workspace() end,         desc = '[D]iagnostics' },
      { '<leader>fr',  function() FzfLua.live_grep_resume() end,              desc = '[R]esume' },
    })
    FzfLua.setup({})
  end
}
