local null_ls = require("null-ls")


local sources = {
    -- Python
    null_ls.builtins.formatting.black.with {
        args = { "--line-length", "100" },
        filetypes = { "python" },
    },
    null_ls.builtins.formatting.ruff.with {
        filetypes = { "python" },
    },
    null_ls.builtins.formatting.isort.with {
        filetypes = { "python" },
    },
    null_ls.builtins.diagnostics.ruff.with {
        filetypes = { "python" },
    },
    null_ls.builtins.diagnostics.mypy.with {
        filetypes = { "python" },
    },

    -- JavaScript / TypeScript / Svelte
    null_ls.builtins.formatting.prettier.with {
        filetypes = { "svelte", "javascript", "typescript", "css", "scss", "sass", "json" },
    },
    null_ls.builtins.diagnostics.eslint.with {
        filetypes = { "svelte", "javascript", "typescript" },
    },

}

null_ls.setup({
    sources = sources,
    diagnostics_format = "#{m} #{s}[#{c}]",
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end
                    })
                end,
            })
        end
    end,
})
