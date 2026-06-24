-- inspired by 

-- luasnip.lua
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

-- context checker
local function in_mathzone()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local function math_auto(trig, expansion)
    return s(
        { trig = trig, snippetType = "autosnippet" },
        { t(expansion) },
        { condition = in_mathzone }
    )
end

-- superscripts & subscripts (autosnippets)
ls.add_snippets("tex", {
    s(
        { trig = "([%w%)%]%}])%^", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("{}^{{{}}}", {
            f(function(_, snip) return snip.captures[1] end),
            i(1)
        }),
        { condition = in_mathzone }
    ),
    s(
        { trig = "([%w%)%]%}])_", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("{}_{{{}}}", {
            f(function(_, snip) return snip.captures[1] end),
            i(1)
        }),
        { condition = in_mathzone }
    ),
})

-- dynamic fraction (autosnippet)
ls.add_snippets("tex", {
    s(
        { trig = "([^%s%$]+)/", regTrig = true, trigEngine = "pattern", snippetType = "autosnippet" },
        fmt("\\frac{{{}}}{{{}}}", {
            f(function(_, snip) return snip.captures[1] end),
            i(1)
        }),
        { condition = in_mathzone }
    )
})

-- math & logic (autosnippets in mathzone)
ls.add_snippets("tex", {
    math_auto("<=", "\\leq "),
    math_auto(">=", "\\geq "),
    math_auto("!=", "\\neq "),
    math_auto("sub=", "\\subseteq "),
    math_auto("sup=", "\\supseteq "),
    math_auto("xx", "\\times "),
    math_auto("cdot", "\\cdot "),
    math_auto("->", "\\to "),
    math_auto("<-", "\\leftarrow "),
    math_auto("inn", "\\in "),
    math_auto("notin", "\\not\\in "),
    math_auto("iff", "\\iff "),
    math_auto("implies", "\\implies "),
    math_auto("implied", "\\impliedby "),
    math_auto("land", "\\land "),
    math_auto("OR", "\\lor "),
})

ls.add_snippets("tex", {
    -- quantifiers with variable placeholders
    s({ trig = "fa", snippetType = "autosnippet" }, fmt("\\forall {}, ", { i(1) }), { condition = in_mathzone }),
    s({ trig = "ex", snippetType = "autosnippet" }, fmt("\\exists {}, ", { i(1) }), { condition = in_mathzone }),
    s({ trig = "nex", snippetType = "autosnippet" }, fmt("\\nexists {}, ", { i(1) }), { condition = in_mathzone }),

    -- turnstiles
    math_auto("ts", "\\vdash "),
    math_auto("models", "\\vDash "),
    math_auto("equiv", "\\equiv "),
    
    math_auto("neg", "\\neg "),
    math_auto("mto", "\\mapsto "),
})

ls.add_snippets("tex", {
    math_auto("NN", "\\N"),
    math_auto("ZZ", "\\Z"),
    math_auto("QQ", "\\Q"),
    math_auto("RR", "\\R"),
    
    math_auto("cup", "\\cup "),
    math_auto("cap", "\\cap "),
    math_auto("empty", "\\emptyset"),
    math_auto("sm", "\\setminus "),
    math_auto("bsm", "\\setminus "),
})

-- brackets
ls.add_snippets("tex", {
    s({ trig = "lr(", snippetType = "autosnippet" }, fmt("\\left( {} \\right)", { i(1) }), { condition = in_mathzone }),
    s({ trig = "lr[", snippetType = "autosnippet" }, fmt("\\left[ {} \\right]", { i(1) }), { condition = in_mathzone }),
    s({ trig = "lr{", snippetType = "autosnippet" }, fmt("\\left\\{{ {} \\right\\}}", { i(1) }), { condition = in_mathzone }),
    s({ trig = "lr|", snippetType = "autosnippet" }, fmt("\\left| {} \\right|", { i(1) }), { condition = in_mathzone }),
})

-- equations
ls.add_snippets("tex", {
    -- align
    s("ali", fmt([[
        \begin{{align*}}
            {} & {} \\\\
            {}
        \end{{align*}}
        ]], { i(1), i(2), i(0) })),
        
    -- cases
    s("cases", fmt([[
        \begin{{cases}}
            {} & \text{{if }} {} \\\\
            {} & \text{{otherwise}}
        \end{{cases}}
        ]], { i(1), i(2), i(3) }), { condition = in_mathzone }),
})

-- greek letters (autosnippets in mathzone)
ls.add_snippets("tex", {
    math_auto("@a", "\\alpha"),
    math_auto("@b", "\\beta"),
    math_auto("@g", "\\gamma"),
    math_auto("@d", "\\delta"),
    math_auto("@e", "\\epsilon"),
    math_auto("@z", "\\zeta"),
    math_auto("@h", "\\eta"),
    math_auto("@th", "\\theta"),
    math_auto("@i", "\\iota"),
    math_auto("@k", "\\kappa"),
    math_auto("@l", "\\lambda"),
    math_auto("@m", "\\mu"),
    math_auto("@n", "\\nu"),
    math_auto("@x", "\\xi"),
    math_auto("@p", "\\pi"),
    math_auto("@r", "\\rho"),
    math_auto("@s", "\\sigma"),
    math_auto("@t", "\\tau"),
    math_auto("@u", "\\upsilon"),
    math_auto("@ph", "\\phi"),
    math_auto("@ch", "\\chi"),
    math_auto("@ps", "\\psi"),
    math_auto("@w", "\\omega"),

    math_auto("@G", "\\Gamma"),
    math_auto("@D", "\\Delta"),
    math_auto("@Th", "\\Theta"),
    math_auto("@L", "\\Lambda"),
    math_auto("@X", "\\Xi"),
    math_auto("@P", "\\Pi"),
    math_auto("@S", "\\Sigma"),
    math_auto("@Ph", "\\Phi"),
    math_auto("@W", "\\Omega"),
})

-- bar, hat, vec etc
ls.add_snippets("tex", {
    s(
        { trig = "(%a)bar", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("\\overline{{{}}}", { f(function(_, snip) return snip.captures[1] end) }),
        { condition = in_mathzone }
    ),
    s(
        { trig = "(%a)hat", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("\\hat{{{}}}", { f(function(_, snip) return snip.captures[1] end) }),
        { condition = in_mathzone }
    ),

    -- ., e ,. = vec
    s(
        { trig = "(%a),%.", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("\\vec{{{}}}", { f(function(_, snip) return snip.captures[1] end) }),
        { condition = in_mathzone }
    ),
    s(
        { trig = "(%a)%.,", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmt("\\vec{{{}}}", { f(function(_, snip) return snip.captures[1] end) }),
        { condition = in_mathzone }
    ),
})

ls.add_snippets("tex", {
    s(
        { trig = "lim", snippetType = "autosnippet" }, 
        fmt("\\lim_{{{} \\to {}}} {}", { i(1, "n"), i(2, "\\infty"), i(0) }), 
        { condition = in_mathzone }
    ),
    s(
        { trig = "sum", snippetType = "autosnippet" }, 
        fmt("\\sum_{{{}={}}}^{{{}}} {}", { i(1, "n"), i(2, "1"), i(3, "\\infty"), i(0) }), 
        { condition = in_mathzone }
    ),
})

-- my environments
ls.add_snippets("tex", {
    s("beg", fmt([[
        \begin{{{}}}
            {}
        \end{{{}}}
        ]], { i(1), i(0), rep(1) })),

    s("def", fmt([[
        \begin{{defframe}}{{{}}}{{}}
            {}
        \end{{defframe}}
        ]], { i(1), i(0) })),

    s("note", fmt([[
        \begin{{gframe}}{{{}}}
            {}
        \end{{gframe}}
        ]], { i(1), i(0) })),

    s("proof", fmt([[
        \begin{{proofframe}}{{{}}}{{}}
            {}
        \end{{proofframe}}
        ]], { i(1), i(0) })),

    s("thm", fmt([[
        \begin{{thmframe}}{{{}}}{{}}
            {}
        \end{{thmframe}}
        ]], { i(1), i(0) })),

    s("lemma", fmt([[
        \begin{{lemmaframe}}{{{}}}{{}}
            {}
        \end{{lemmaframe}}
        ]], { i(1), i(0) })),

    s("prop", fmt([[
        \begin{{propframe}}{{{}}}{{}}
            {}
        \end{{propframe}}
        ]], { i(1), i(0) })),

    s("pf", fmt([[
        \begin{{pframe}}
            {}
        \end{{pframe}}
        ]], { i(0) })),

    s("cdef", fmt([[
        \begin{{cdefframe}}{{{}}}{{{}}}{{{}}}
            {}
        \end{{cdefframe}}
        ]], { i(1, "bg_color"), i(2, "title_color"), i(3, "title"), i(0) })),

    s("cf", fmt([[
        \begin{{cframe}}{{{}}}{{{}}}{{{}}}
            {}
        \end{{cframe}}
        ]], { i(1, "bg_color"), i(2, "title_color"), i(3, "title"), i(0) })),

    s("cor", fmt([[
        \begin{{corframe}}{{{}}}
            {}
        \end{{corframe}}
        ]], { i(1, "title"), i(0) })),
    s("bd", { t("\\textbf{"), i(1), t("}") }),
    s("it", { t("\\textit{"), i(1), t("}") }),

    s({ trig = "mk", snippetType = "autosnippet" }, { t("$"), i(1), t("$") }),
    s({ trig = "dm", snippetType = "autosnippet" }, { t("\\[ "), i(1), t(" \\]") }),
})


