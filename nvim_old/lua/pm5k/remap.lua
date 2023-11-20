local langs = require("pm5k.helpers.langlist")


--[[ PRE ]]

-- Remap leader to space at the very start.
-- This gets loaded before any other module,
-- which means that leader should work properly..
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Disable arrows to prevent "cheating" when learning.
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Left>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Right>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Up>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Down>", "<Nop>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})

--[[ CLIPBOARD ]]

-- Highlight on yank. See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = "*",
})
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Primagen: greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Primagen: next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])


-- [[ GREP, SEARCH & REPLACE ]]

local options = { desc = "Global cword search using grep.", remap = false }

-- Search for word under the cursor position in current file, output a list of matches.
vim.keymap.set("n", "<leader>s", ":g/<C-R><C-W>/#<CR>", options)

-- Search for word under cursor in current file and replace it with
-- what you type in the input field.
vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/")

--[[ MOVEMENT ]]

-- Keep search terms in the middle of screen when using
-- / or ? to search and then "n" or "N" to go to next/previous match.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move half a screen up/down and keep cursor in the middle
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move line/selection up
-- vim.keymap.set("n", "<M-k>", ":m .-2<CR>")
-- vim.keymap.set("v", "<M-k>", ":m -2<CR>gv=gv")

-- Move line/selection down
-- vim.keymap.set("n", "<M-j>", ":m .+1<CR>")
-- vim.keymap.set("v", "<M-j>", ":m '>+<CR>gv=gv")


-- [[ MISC ]]

-- Convenience bind to enable syntax highlight on buffers that were not opened as:
-- `nvim somefile` or some other way. This is so that if I ever wanna just do `nvim`
-- to quickly dick around or have a bind to swap highlight languages on the fly - I can.
-- Note: this uses the `langlist.lua` import and populates the language selection accordingly.
if not vim.g.vscode then
    vim.keymap.set("n", "<leader>ll", function()
        vim.ui.select(langs, {
            prompt = "Select language for syntax highlighting:",
            format_item = function(item)
                return item
            end,
        }, function(choice)
            if (choice) then
                vim.opt.filetype = choice
            end
        end)
    end)
end

-- Convenience bind for escaping insert mode.
vim.keymap.set("i", "<C-c>", "<Esc>")
