------------------------------------------------
local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

nmap = bind("n", {noremap = false})
nnoremap = bind("n") -- Normal
vnoremap = bind("v") -- Visual + Select
xnoremap = bind("x") -- Select only
inoremap = bind("i") -- Insert
tnoremap = bind("t") -- Terminal
map = bind("")       -- Normal, Visual, Select
-------------------------------------------------

-- Navigate windows with ctrl + shift + hjkl
map("<C-J>", "<C-W>j")
map("<C-K>", "<C-W>k")
map("<C-L>", "<C-W>l")
map("<C-H>", "<C-W>h")

-- alt + h unhighlights
map("<A-h>", ":noh<CR>")

-- Stay in visual mode after indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- No-op stupid commands that are annoying
nnoremap("q:", "<nop>")
nnoremap("Q", "<nop>")

nnoremap("Y", "Y$")

nnoremap("<F2>", ":Neotree reveal=true<CR>")

map("<C-R>a", ":sort<CR>", {silent = true})
map("<C-R>d", ":sort!<CR>", {silent = true})

nnoremap("<leader>gg", ":LazyGit<CR>", {silent = true})