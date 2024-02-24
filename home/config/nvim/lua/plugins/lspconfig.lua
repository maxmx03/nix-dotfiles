return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local icons = require 'core.icons'
      local servers = require 'servers'

      local signs = {
        Error = icons.diagnostics.Error,
        Warn = icons.diagnostics.Warning,
        Hint = icons.diagnostics.Hint,
        Info = icons.diagnostics.Information,
      }

      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config {
        virtual_text = {
          prefix = '●',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),

        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local bufnr = ev.buf
          require('lsp_signature').on_attach({
            floating_window = false,
            hint_prefix = '🤔 ',
            hint_scheme = 'String',
          }, bufnr)
        end,
      })

      for _, server in ipairs(servers) do
        if server == 'lua_ls' then
          lspconfig[server].setup {
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                    '${3rd}/busted/library',
                    '~/.local/share/nvim/lazy/dracula.nvim',
                  },
                },
                hint = {
                  enable = true,
                },
                completion = {
                  callSnippet = 'Replace',
                },
              },
            },
            capabilities = capabilities,
          }
        else
          lspconfig[server].setup {
            capabilities = capabilities,
          }
        end
      end
    end,
  },
}
