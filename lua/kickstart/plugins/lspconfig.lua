return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.filetype.add {
        extension = {
          bicep = 'bicep',
          bicepparam = 'bicep-params',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, 'References')
          map('gri', require('telescope.builtin').lsp_implementations, 'Implementation')
          map('grd', require('telescope.builtin').lsp_definitions, 'Definition')
          map('grD', vim.lsp.buf.declaration, 'Declaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = { spacing = 2 },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        bicep = {
          cmd = { 'bicep-lsp' },
          filetypes = { 'bicep', 'bicep-params' },
          root_dir = function(fname)
            local git = vim.fs.find('.git', { path = fname, upward = true })[1]
            return vim.fs.dirname(git or fname)
          end,
          init_options = {},
        },
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { 'stylua' })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
          end,
        },
      }
    end,
  },
}
