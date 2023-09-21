-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help "clipboard"`
-- Thanks to: https://github.com/LunarVim/LunarVim/issues/4026
-- Also see: https://github.com/neovim/neovim/wiki/FAQ#old-instructions
vim.g.clipboard = {
    name = "win32yank",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
}

-- Enable mouse mode
vim.o.mouse = "a"

-- Line Number Config
vim.opt.nu = true
vim.opt.relativenumber = true
vim.wo.number = true

-- Tabs & Indentation
vim.o.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Undotree-specific
-- Enable this in linux
if not vim.fn.has('win32') then
    vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
end
vim.opt.undofile = true

-- Search-specific
vim.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = false
vim.o.smartcase = true

-- Misc
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50 -- 200
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.opt.colorcolumn = "100"
vim.o.completeopt = "menuone,noselect"
vim.opt.splitbelow = true
-- Disable welcome message
vim.o.shortmess = "I"
