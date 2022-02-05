local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")

local snippets = {
  s({trig="inc", dscr="Include system header"}, {
    t("#include <"), i(1), t({">"}),
  }),

  -- TODO: Set default text to corresponding header
  s({trig="Inc", dscr="Include local header"}, {
    t("#include \""), i(1), t({"\""}),
  }),

  s({trig="for", dscr="Classic for loop"}, {
    t("for ("), i(1, "size_t"),
    t(" "), i(2, "i"),
    t(" = "), i(3, "0"),
    t("; i "), i(4, "<"),
    t(" "), i(5),
    t(";"), i(6, "++i"),
    t({") {", "\t"}), i(0),
    t({"", "}"}),
  }),

  s({trig="fore", dscr="Foreach loop"}, {
    t("for ("), c(1,
      {t("auto "), t("const auto "), t("auto &"), t("const auto &")}),
    i(2, "elem"),
    t(" : "), i(3, "set"),
    t({") {", "\t"}), i(0),
    t({"", "}"}),
  }),

  s({trig="while", dscr="While loop"}, {
    t("while ("), i(1),
    t({") {", "\t"}), i(0),
    t({"", "}"}),
  }),
}

return snippets
