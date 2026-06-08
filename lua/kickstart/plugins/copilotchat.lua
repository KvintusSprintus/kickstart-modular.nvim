return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',

    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      { 'ravitemer/mcphub.nvim' },
    },

    build = 'make tiktoken',

    opts = {
      model = 'gpt-5-mini',
    },

    config = function(_, opts)
      require('CopilotChat').setup(opts)

      require('mcphub.extensions.copilotchat').setup()
    end,

    keys = {
      {
        '<leader>cc',
        '<cmd>CopilotChatToggle<CR>',
        desc = 'Toggle Copilot Chat',
      },

      {
        '<leader>co',
        '<cmd>CopilotChatOpen<CR>',
        desc = 'Open Copilot Chat',
      },

      {
        '<leader>ce',
        ':CopilotChatExplain<CR>',
        mode = 'v',
        desc = 'CopilotChat: Explain selection',
      },

      {
        '<leader>cx',
        '<cmd>CopilotChatClose<CR>',
        desc = 'Close Copilot Chat',
      },
    },
  },
}
