return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',

    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        opts = {},
      },

      'folke/lazydev.nvim',
      'fang2hou/blink-copilot',
    },

    opts = {
      keymap = {
        preset = 'none',
        ['<C-y>'] = { 'select_and_accept' },
        --['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        -- Optional but useful additions for your new setup:
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
          window = {
            border = 'rounded',
            max_width = 80,
            max_height = 40,
          },
        },

        menu = {
          direction_priority = { 'n', 's' },
        },
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'lazydev',
          'copilot',
        },

        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },

          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },

      snippets = {
        preset = 'luasnip',
      },

      fuzzy = {
        implementation = 'lua',
      },

      signature = {
        enabled = true,
      },
    },
  },
}
