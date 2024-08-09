return function(activate)
  local plugin = {
    "neovim/nvim-lspconfig",
    enabled = false,
  }

  if activate then
    plugin = {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("nvchad.configs.lspconfig").defaults()

        -- custom configs
        local on_attach = require("nvchad.configs.lspconfig").on_attach
        local on_init = require("nvchad.configs.lspconfig").on_init
        local capabilities = require("nvchad.configs.lspconfig").capabilities

        local lspconfig = require "lspconfig"

        -- list of all servers configured.
        lspconfig.servers = {
          "lua_ls",
          "intelephense",
          "phpactor",
        }

        -- list of servers configured with default config.
        local default_servers = {
          "bashls",
          "jsonls",
          "yamlls",
        }

        -- lsps with default config
        for _, lsp in ipairs(default_servers) do
          lspconfig[lsp].setup {
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
          }
        end

        -- lsps with custom config lua_ls
        lspconfig.lua_ls.setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,

          settings = {
            Lua = {
              diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
              },
              workspace = {
                library = {
                  vim.fn.expand "$VIMRUNTIME/lua",
                  vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                  vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                  vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
            },
          },
        }

        lspconfig.intelephense.setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,

          init_options = {
            globalStoragePath = os.getenv "HOME" .. "/.local/share/intelephense",
          },

          settings = {
            intelephense = {
              diagnostics = {
                enable = false,
              },
              stubs = {
                "bcmath",
                "bz2",
                "Core",
                "curl",
                "date",
                "dom",
                "fileinfo",
                "filter",
                "gd",
                "gettext",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "libxml",
                "mbstring",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "regex",
                "session",
                "SimpleXML",
                "sockets",
                "sodium",
                "standard",
                "superglobals",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlwriter",
                "yaml",
                "zip",
                "zlib",
                "wordpress-stubs",
                "woocommerce-stubs",
                "acf-pro-stubs",
                "wordpress-globals",
                "wp-cli-stubs",
                "genesis-stubs",
                "polylang-stubs",
              },
              files = {
                associations = {
                  "*.php",
                  "*.module",
                  "*.inc",
                  "*.install",
                },
              },
            },
          },
        }

        -- lspconfig.phpactor.setup {
        --   on_attach = on_attach,
        --   on_init = on_init,
        --   capabilities = capabilities,
        -- }

        local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
        phpactor_capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }

        phpactor_capabilities["textDocument"]["codeAction"] = {}
        lspconfig.phpactor.setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        }
      end,
    }
  end

  return plugin
end
