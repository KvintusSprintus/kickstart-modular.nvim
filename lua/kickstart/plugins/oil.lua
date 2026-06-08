return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = 'actions.parent',
      ['<C-l>'] = 'actions.select',
    },
  },
  keys = {
    { '<leader>o', '<cmd>Oil<CR>', desc = 'Open parent directory with Oil' },
  },
}
