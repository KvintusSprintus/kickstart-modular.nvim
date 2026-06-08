return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.comment').setup()
      local commentstrings = {
        bicep = '// %s',
        bicepparam = '// %s',
        yaml = '# %s',
        yml = '# %s',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(commentstrings),
        callback = function()
          vim.bo.commentstring = commentstrings[vim.bo.filetype]
        end,
      })
    end,
  },
}
