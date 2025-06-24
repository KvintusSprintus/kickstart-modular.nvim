return {
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vague').setup {
        -- optional customization:
        bold = false,
        italics = false,
      }
      vim.cmd 'colorscheme vague'
    end,
  },
}
