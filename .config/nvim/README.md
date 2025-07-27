## nvim setup so i can remember the stuff i've set up
(i still lowkey suck at vim motions)

### keymaps:

(leader key is `,`)

**SNIPPETS !**

- `CTRL-l` expands snippet
- `CTRL-k`, `CTRL-j` jump forwards and backwards in snippet anchors
- these same things can be accomplished (thanks to cmp) with:
  * tabbing to the correct snippet in the cmp preview + `Enter` to choose it
  * `Tab` again to move to next anchor
 
- `CTRL-Space` auto-selects the first snippet in the menu
- `CTRL-e` aborts autocmp (for that word)

**LSP**

- `,H` - hover over code (gives 'definitions' of code)
- `,gd` - goes to definition (e.g., jumps to variable definition if used on a variable)
- `,ca` - code actions

**telescope**

- `,p` - find files (from cwd)
- `,fg` - fuzzy finder

**neotree**

- `,n` - reveal filesystem (left)
- `CTRL-w-w` - switches between files and tree

**none-ls**

- `,gf` - formats code better (technically) (have to dfix)

---

### plugins:

- **autoclose.nvim** – autocloses parentheses, quotes etc
- **better-escape.nvim** – remaps `jj` to `<Esc>` (without delay)
- **nvim-cmp** – autocomplete snippets (code suggestions etc), integrated with luasnip for custom snippets
- **nvim-colorizer** – shows color previews on hex text
- **live-server.nvim** – live reload server for HTML/CSS
- **mason + lspconfig + none-ls** – for language servers *(TODO: setup better ngl)*
- **markdown-preview\.nvim** – markdown live server
- **neo-tree.nvim** – filesystem previewer *(setup better maybe)*
- **telescope** – better fuzzy finder *(setup better)*
- **nvim-treesitter** – better syntax highlighting
- **VimTeX** – LaTeX helper
- **which-key.nvim** – helps with keybindings *(I forget mine, plan on removing this soon)*

#### "visual" plugins

- **alpha-nvim** – pretty nvim startup page with shortcuts
- **lualine** – github status
tionsf
