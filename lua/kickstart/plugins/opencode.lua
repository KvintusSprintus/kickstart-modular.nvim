return {
  {
    'nickjvandyke/opencode.nvim',
    version = '*', -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
          terminal = {}, -- Enables the `snacks` provider
        },
      },
    },
    config = function()
      local opencode_cmd = 'opencode --port --agent plan'
      local side_by_side_opts = {
        split = 'right',
        width = math.floor(vim.o.columns * 0.5),
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require('opencode.terminal').open(opencode_cmd, side_by_side_opts)
          end,
          toggle = function()
            require('opencode.terminal').toggle(opencode_cmd, side_by_side_opts)
          end,
        },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = 'Ask opencode…' })
      vim.keymap.set({ 'n', 'x' }, '<leader>ax', function()
        require('opencode').select()
      end, { desc = 'Execute opencode action…' })
      vim.keymap.set('n', '<leader>at', function()
        require('opencode').toggle()

        vim.schedule(function()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            local bt = vim.bo[buf].buftype
            local name = vim.api.nvim_buf_get_name(buf)

            if ft:find 'opencode' or (bt == 'terminal' and name:find 'opencode') then
              vim.api.nvim_set_current_win(win)
              vim.cmd.startinsert()
              return
            end
          end
        end)
      end, { desc = 'Toggle opencode' })

      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return require('opencode').operator '@this '
      end, { desc = 'Add range to opencode', expr = true })
      vim.keymap.set('n', 'goo', function()
        return require('opencode').operator '@this ' .. '_'
      end, { desc = 'Add line to opencode', expr = true })

      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'Scroll opencode up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'Scroll opencode down' })

      -- You may want these if you use opinionated `<C-a>` and `<C-x>` mappings for something else.
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
    end,
  },
}
