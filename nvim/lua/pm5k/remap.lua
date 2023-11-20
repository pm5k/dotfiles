-- Import our langlist which we can easily edit to add/remove languages
local langs = require("pm5k.helpers.langlist")


-- [[ Basic Keymaps ]]
-- Disable arrows to prevent "cheating" when learning.
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Left>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Right>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Up>", "<Nop>")
vim.keymap.set({ "v", "i", "s", "o", "n" }, "<Down>", "<Nop>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Primagen: greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Primagen: next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


--[[ MOVEMENT ]]
-- Keep search terms in the middle of screen when using
-- / or ? to search and then "n" or "N" to go to next/previous match.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move half a screen up/down and keep cursor in the middle
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")


--[[ MISC ]]
-- Convenience bind for escaping insert mode.
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Only active if not inside VSCode's nvim plugin to avoid conflicts with VSC binds.
if not vim.g.vscode then
    -- Move line/selection up
    vim.keymap.set("n", "<M-k>", ":m .-2<CR>")
    vim.keymap.set("v", "<M-k>", ":m -2<CR>gv=gv")

    -- Move line/selection down
    vim.keymap.set("n", "<M-j>", ":m .+1<CR>")
    vim.keymap.set("v", "<M-j>", ":m '>+<CR>gv=gv")

    -- Convenience bind to enable syntax highlight on buffers that were not opened as:
    -- `nvim somefile` or some other way. This is so that if I ever wanna just do `nvim`
    -- to quickly dick around or have a bind to swap highlight languages on the fly - I can.
    -- Note: this uses the `langlist.lua` import and populates the language selection accordingly.
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

-- <Leader>+Tab toggles OIL
vim.keymap.set("n", "<leader><Tab>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
