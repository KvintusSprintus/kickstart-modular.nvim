vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.bicepparam',
  callback = function()
    vim.bo.filetype = 'bicep-params'
  end,
})
