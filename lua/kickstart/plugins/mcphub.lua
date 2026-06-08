return {
  {
    'ravitemer/mcphub.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    opts = {
      extensions = {
        copilotchat = {
          enabled = true,

          convert_tools_to_functions = true,
          convert_resources_to_functions = true,

          add_mcp_prefix = false,
        },
      },
    },

    config = function(_, opts)
      require('mcphub').setup(opts)
    end,
  },
}
