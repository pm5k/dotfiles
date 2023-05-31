local function req(file) require("pm5k.configs." .. file) end

local plugins = {
    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-sleuth",

    -- Mason related plugins
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            { "j-hui/fidget.nvim",       opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim"
        },
        config = function() req("lsp") end,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
        config = function() req("cmp") end,
        lazy = true,
        event = { "InsertEnter" },
    },

    -- Useful plugin to show you pending keybinds.
    {"folke/which-key.nvim", opts = {}},

    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" }
            }
        }
    },

    -- Set lualine as statusline
    {
        "nvim-lualine/lualine.nvim",
        requires = { "ryanoasis/vim-devicons", opt = true, lazy=true },
    },

    -- Add indentation guides even on blank lines
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function() req("blankline") end,
        event = "VeryLazy",
    },

    -- "gc" to comment visual regions/lines
    {"numToStr/Comment.nvim", opts = {}},

    -- Fuzzy Finder (files, lsp, etc)
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable "make" == 1 end
    },

    -- Highlight, edit, and navigate code
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate"
    },

    -- require "kickstart.plugins.debug",
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "LspAttach",
        config = function() req("null_ls") end,
    },

    "theprimeagen/harpoon",
    "MunifTanjim/prettier.nvim",
    "romgrk/fzy-lua-native",

    {
        "gelguy/wilder.nvim",
        config = function() req("wilder") end,
        event = "VeryLazy"
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<c-y>",
                        --   accept_word = false,
                        --   accept_line = false,
                        --   next = "<M-]>",
                        --   prev = "<M-[>",
                        --   dismiss = "<C-]>",
                    },
                },
            })
        end
    },

    {
        "zbirenbaum/copilot-cmp",
        config = function () require("copilot_cmp").setup() end,
    },
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     config = function() req("nvimtree") end,
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function() req("neotree") end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
}

local opts = {
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/lazy/cache",
            ttl = 3600 * 24 * 5,
            disable_events = { "VimEnter", "BufReadPre", "UIEnter" },
        },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                -- "netrwPlugin",
                -- "netrwSettings",
                -- "netrwFileHandlers",
                -- "netrw",
                -- "matchparen",
                -- "2html_plugin",
                -- "getscript",
                -- "getscriptPlugin",
                -- "gzip",
                -- "logipat",
                -- "matchit",
                -- "tar",
                -- "tarPlugin",
                -- "rrhelper",
                -- "vimball",
                -- "vimballPlugin",
                -- "zip",
                -- "zipPlugin",
                "tutor",
                -- "rplugin",
                -- "bugreport",
                "tutor_mode_plugin",
                -- "fzf",
                -- "sleuth",
            },
        },
    }
}

require("lazy").setup( plugins, opts)
