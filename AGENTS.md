# AGENTS

## Repo Shape
- This is a modular Neovim config fork; runtime entrypoint is `init.lua`.
- `init.lua` loads, in order: `lua/options.lua`, `lua/keymaps.lua`, `lua/lazy-bootstrap.lua`, `lua/lazy-plugins.lua`, then `lua/custom/plugins/autocmds.lua`.
- Plugin specs are wired manually in `lua/lazy-plugins.lua` via `require 'kickstart.plugins.*'`; `import = 'custom.plugins'` is commented out, so files in `lua/custom/plugins/*.lua` are not auto-loaded.

## Commands That Matter
- Format check used by CI config: `stylua --check .`
- Local formatting behavior is driven by Conform (`<leader>f` or on save) and uses `stylua` for Lua (`lua/kickstart/plugins/conform.lua`).
- Health checks are intended to be run from Neovim via `:checkhealth` (see `lua/kickstart/health.lua`).

## Tooling/Runtime Quirks
- LSP/tool install is Mason-driven from `lua/kickstart/plugins/lspconfig.lua`; ensured tools are `rust_analyzer`, `lua_ls`, `bicep`, and `stylua`.
- Bicep params support is custom: `*.bicepparam` maps to filetype `bicep-params` (in both `vim.filetype.add` and `lua/custom/plugins/autocmds.lua`), and bicep LSP is configured with `cmd = { 'bicep-lsp' }`.
- External executables explicitly checked by repo health logic: `git`, `make`, `unzip`, `rg`.

## CI / VCS Gotchas
- `.github/workflows/stylua.yml` is gated with `if: github.repository == 'nvim-lua/kickstart.nvim'`; this check does not run in most forks.
- `.gitignore` ignores `lazy-lock.json`; lockfile updates will not be staged unless force-added.
