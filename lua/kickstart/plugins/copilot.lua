return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',

    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = false,
      },
      panel = { enabled = false },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },

    build = 'make tiktoken',

    opts = {},

    keys = {
      {
        '<leader>cc',
        '<cmd>CopilotChatToggle<CR>',
        desc = 'Toggle Copilot Chat',
      },
    },
  },
}
