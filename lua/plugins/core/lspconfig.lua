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
        local configs = require "nvchad.configs.lspconfig"
        local lspconfig = require "lspconfig"

        local servers = {
          html = {},
          cssls = {},
          css_variables = {},
          bashls = {},
          yamlls = {},
          jsonls = {},
          dockerls = {},
          docker_compose_language_service = {},
          tsserver = {},
          ansiblels = {},
          marksman = {},
          terraformls = {},
          emmet_ls = {},
          volar = {},
          taplo = {},
          autotools_ls = {},

          lua_ls = {
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
          },

          intelephense = {
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
                environment = {
                  includePaths = os.getenv "HOME" .. "/.composer/vendor/php-stubs/", -- this line forces the composer path for the stubs in case inteliphense don't find it...
                },
                files = {
                  associations = {
                    "*.php",
                    "*.module",
                    "*.inc",
                    "*.install",
                  },
                  maxSize = 5000000,
                },
              },
            },
          },

          phpactor = {},

          pyright = {
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  typeCheckingMode = "basic",
                },
              },
            },
          },
        }

        -- list of all servers in lspconfig.
        lspconfig.servers = {}
        for name, _ in pairs(servers) do
          table.insert(lspconfig.servers, name)
        end

        -- configure specifically for each lsp server
        for name, opts in pairs(servers) do
          opts.on_init = configs.on_init
          opts.on_attach = configs.on_attach
          opts.capabilities = configs.capabilities

          require("lspconfig")[name].setup(opts)
        end

        -- configure phpactor lsp server
        local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
        phpactor_capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
        phpactor_capabilities["textDocument"]["codeAction"] = {}
      end,
    }
  end

  return plugin
end
