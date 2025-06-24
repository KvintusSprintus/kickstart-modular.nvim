return {
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanso').setup {
        -- optional customization:
        bold = true,
        italics = false,
        theme = 'ink', -- options: "zen", "ink", "mist", "pearl"
      }
      vim.cmd 'colorscheme kanso'
    end,
  },
}
