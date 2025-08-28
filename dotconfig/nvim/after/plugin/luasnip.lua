local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

ls.add_snippets("lua", {
  s("hello", { t('print("gelo world")') })
})

local matchstring = "match {}:\n\tcase {}:\n\t\t{}\n\tcase _:\n\t\t{}";
ls.add_snippets("tex", {
  s("begin", {
        t("\\begin{"), i(1), t("}"),
        t({ "", "\t" }), i(0),
        t({ "", "\\end{" }), rep(1), t("}"),
    })
})

ls.add_snippets("python", {
  s("for",
    fmt("for {} in {}:\n\t{}",
      { i(1, "item"), i(2, "expression"), i(0, "commands") }
    )),
  s("while",
    fmt("while {}:\n\t{}",
      { i(1, "condition"), i(0, "commands") }
    )),
  s("if else",
    fmt("if ({}):\n\t{}\nelse:\n\t{}",
      { i(1, "condition"), i(2, "commands"), i(0, "commands") }
    )),
  s("if",
    fmt("if ({}):\n\t{}",
      { i(1, "condition"), i(0, "commands") }
    )),
  s("match",
    fmt(matchstring,
      { i(1, "variable"), i(2, "value"), i(3, "commands"), i(0, "commands") }
    )),
  s("case",
    fmt(matchstring, { i(1, "variable"), i(2, "value"), i(3, "commands"), i(0, "commands") }
    )),
  s("switch",
    fmt(matchstring, { i(1, "variable"), i(2, "value"), i(3, "commands"), i(0, "commands") }
    )),
  s("def",
    fmt("def {}({}):\n\t{}", { i(1, "function"), i(2, "parameters"), i(0, "commands") }
    )),
  s("class",
    fmt("class {}:\n\t{}", { i(1, "class"), i(0, "contents") }
    )),
})
