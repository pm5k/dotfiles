-- Big thanks to xorg-dogma for this.
-- Will open a terminal buffer if none exist, otherwise it will close the existing one
-- to avoid having to spawn multiples. Essentially a quick terminal toggle using a buffer.

local M = {}

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.g.terminal_open = vim.api.nvim_get_current_buf()
    vim.cmd.set("filetype=terminal")
  end,
})

function M.terminal()
  local binfo = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
  local bufhidden = vim.tbl_filter(function(b) return b.hidden == 0 end, binfo)
  local bufnrs = vim.tbl_map(function(b) return b.bufnr end, bufhidden)
  if vim.g.terminal_open and vim.tbl_contains(bufnrs, vim.g.terminal_open) then
    vim.api.nvim_buf_delete(vim.g.terminal_open, { force = true })
    vim.g.terminal_open = nil
    return
  end
  vim.cmd.terminal()
end

return M
