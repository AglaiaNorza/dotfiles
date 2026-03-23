-- luasnip.lua
-- THESE ARE THE SNIPPETS
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

--[[
-- i(1), i(0) etc are anchors for the cursor
--
-- rep() repeats what is in the braces
--]]

--[[ beg 1 (old)
ls.add_snippets("tex", {
    s("beg", {
        t("\\begin{"), i(1), t("}"),
        t({"", "\t"}), i(0),
        t({"", "\\end{" }), rep(1), t("}"),
    })

})
--]]

-- helper
local function in_mathzone()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- latex formatting
ls.add_snippets("tex", {
    s("beg", fmt(
        [[
        \begin{{{}}}
            {}
        \end{{{}}}
        ]], {
            i(1), i(0), rep(1)
        }))
})

ls.add_snippets("tex", {
    s("def", fmt(
        [[
        \begin{{defframe}}{{{}}}{{}}
            {}
        \end{{defframe}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("note", fmt(
        [[
        \begin{{gframe}}{{{}}}
            {}
        \end{{gframe}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("proof", fmt(
        [[
        \begin{{proofframe}}{{{}}}{{}}
            {}
        \end{{proofframe}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("thm", fmt(
        [[
        \begin{{thmframe}}{{{}}}{{}}
            {}
        \end{{thmframe}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("lemma", fmt(
        [[
        \begin{{lemmaframe}}{{{}}}{{}}
            {}
        \end{{lemmaframe}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("defbox", fmt(
        [[
        \begin{{defbox}}{{{}}}{{}}
            {}
        \end{{defbox}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("notebox", fmt(
        [[
        \begin{{gbox}}{{{}}}
            {}
        \end{{gbox}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("proofbox", fmt(
        [[
        \begin{{proofbox}}{{{}}}{{}}
            {}
        \end{{proofbox}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("thmbox", fmt(
        [[
        \begin{{thmbox}}{{{}}}{{}}
            {}
        \end{{thmbox}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("lemmabox", fmt(
        [[
        \begin{{lemmabox}}{{{}}}{{}}
            {}
        \end{{lemmabox}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("defnote", fmt(
        [[
        \begin{{defnote}}{{{}}}{{}}
            {}
        \end{{defnote}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("gnote", fmt(
        [[
        \begin{{gnote}}{{{}}}
            {}
        \end{{gnote}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("proofnote", fmt(
        [[
        \begin{{proofnote}}{{{}}}{{}}
            {}
        \end{{proofnote}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("thmnote", fmt(
        [[
        \begin{{thmnote}}{{{}}}{{}}
            {}
        \end{{thmnote}}
        ]], {
            i(1),
            i(0)
        }))
})

ls.add_snippets("tex", {
    s("lemmanote", fmt(
        [[
        \begin{{lemmanote}}{{{}}}{{}}
            {}
        \end{{lemmanote}}
        ]], {
            i(1),
            i(0)
        }))
})



ls.add_snippets("tex", {
    s("mk", {t("$"), i(1), t("$")}),
    s("dm", {t("\\[ "), i(1), t(" \\]")})
})

ls.add_snippets("tex", {
    s("bd", {t("\\textbf{"), i(1), t("}")}),
    s("it", {t("\\textit{"), i(1), t("}")})
})

ls.add_snippets("tex", {
    s(
        { trig = "%^", regTrig = true, wordTrig = false },
        fmt("^{{{}}}", { i(1) })
    ),
    s(
        { trig = "%_", regTrig = true, wordTrig = false },
        fmt("_{{{}}}", { i(1) })
    )
})

-- simple symbols

ls.add_snippets("tex", {
    s("<=", {t("\\leq ")}),
    s(">=", {t("\\geq ")}),
    s("!=", {t"\\neq "}),
    s("sub=", {t("\\subseteq ")}),
    s("sup=", {t("\\supseteq ")}),
})

ls.add_snippets("tex", {
    s("times", {t("\\times ")}),
    s("xx", {t("\\times ")}),
    s("x", {t("\\times ")}),
    s("cdot", {t("\\cdot ")}),
})

-- arrows
ls.add_snippets("tex", {
    s("->", {t("\\to ")}),
    s("<-", {t("\\leftarrow ")}),
})

-- sets 
ls.add_snippets("tex", {
    s("inn", {t("\\in ")}),
    s("notin", {t("\\not\\in ")}),
})

-- logic
ls.add_snippets("tex", {
    s("not", {t("\\not ")}),
    s("iff", {t("\\iff ")}),
    s("implies", {t("\\implies ")}),
    s("im", {t("\\implies ")}),
    s("implied", {t("\\impliedby ")}),
    s("TO", {t("\\to ")}),
    s("land", {t("\\land ")}),
    s("AND", {t("\\land ")}),
    s("OR", {t("\\lor ")}),
})

-- greek letters
ls.add_snippets("tex", {
    -- lowercase
    s("@a", { t("\\alpha") }),
    s("@b", { t("\\beta") }),
    s("@g", { t("\\gamma") }),
    s("@d", { t("\\delta") }),
    s("@e", { t("\\epsilon") }),
    s("@z", { t("\\zeta") }),
    s("@h", { t("\\eta") }),
    s("@th", { t("\\theta") }),
    s("@i", { t("\\iota") }),
    s("@k", { t("\\kappa") }),
    s("@l", { t("\\lambda") }),
    s("@m", { t("\\mu") }),
    s("@n", { t("\\nu") }),
    s("@x", { t("\\xi") }),
    s("@p", { t("\\pi") }),
    s("@r", { t("\\rho") }),
    s("@s", { t("\\sigma") }),
    s("@t", { t("\\tau") }),
    s("@u", { t("\\upsilon") }),
    s("@ph", { t("\\phi") }),
    s("@ch", { t("\\chi") }),
    s("@ps", { t("\\psi") }),
    s("@w", { t("\\omega") }),

    -- capital (some)
    s("@A", { t("\\Alpha") }),
    s("@B", { t("\\Beta") }),
    s("@G", { t("\\Gamma") }),
    s("@D", { t("\\Delta") }),
    s("@Th", { t("\\Theta") }),
    s("@L", { t("\\Lambda") }),
    s("@X", { t("\\Xi") }),
    s("@P", { t("\\Pi") }),
    s("@S", { t("\\Sigma") }),
    s("@U", { t("\\Upsilon") }),
    s("@Ph", { t("\\Phi") }),
    s("@Ps", { t("\\Psi") }),
    s("@W", { t("\\Omega") }),
})

ls.add_snippets("tex", {
    s("èè", {t("È ")}),
})

-- dynamic/fun snippets --

-- fraction
ls.add_snippets("tex", {
    s(
        -- regex for a non-space sequence + a / 
        -- (the parentheses are a "capture group", the text before the /
        -- is captured so it can be inserted in the frac)
        { trig = "([^%s]+)/", regTrig = true, trigEngine = "pattern" },
        fmt("\\frac{{{}}}{{{}}}", {
            -- snip.captures[1] contains the first captured string
            -- (captured via the '()' in the regex)
            f(function(_, snip)
                return snip.captures[1]
            end), -- need a function to wrap the string in a node
            i(1)
        }),
        { condition = in_mathzone }
    )

})

