local buf = nil

vim.keymap.set('n', '<leader>z', function()
  if buf and vim.api.nvim_buf_is_valid(buf) then
    local win_id = vim.fn.bufwinid(buf)
    if win_id ~= -1 then
      vim.api.nvim_win_close(win_id, true)
      return
    end
    -- Buffer exists but hidden — reopen it
    local width = math.floor(vim.o.columns * 0.4)
    vim.api.nvim_set_current_win(vim.api.nvim_open_win(buf, true, {
      split = 'right',
      win = -1,
      width = width,
    }))
    return
  end
  vim.cmd('vsplit | term opencode')
  buf = vim.api.nvim_get_current_buf()
  vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.4))
end, { desc = 'Toggle OpenCode terminal' })
