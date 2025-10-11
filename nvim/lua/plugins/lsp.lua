return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim", config = function() end },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = "FileType",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- 执行 `:help lsp-vs-treesitter` 可以对比两者区别
      --  每当文件打开，关联到某个 lsp server 时，以下函数就会被执行
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- 创建了一个用于映射快捷键的函数
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- 定义 lsp 相关操作的快捷键
          -- 执行 code action
          map('<C-.>', vim.lsp.buf.code_action, 'Goto [C]ode [A]ction', { 'n', 'x' })
          -- map('<leader>ca', vim.lsp.buf.code_action, 'Goto [C]ode [A]ction', { 'n', 'x' })
          map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('gn', vim.lsp.buf.signature_help, '[S]how [S]ignature [H]elp')

          map('gs', Snacks.picker.lsp_symbols, 'Open Document [S]ymbols')
          map('gS', Snacks.picker.lsp_workspace_symbols, 'Open Workspace [S]ymbols')

          map('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
          map('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          map('g[', vim.diagnostic.goto_prev, '[G]oto [P]rev [D]iagnostic')
          map('g]', vim.diagnostic.goto_next, '[G]oto [N]ext [D]iagnostic')

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          -- 检查连接客户段（即 neovim）是否支持 lsp 的特定功能
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- 通过事件数据 (event.data.client_id) 中提供的 ID，获取当前缓冲区（buffer）上连接的 LSP 客户端对象
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- 高亮光标所处的符号以及它所有的引用
          -- 光标移动以及 lsp server detach 的时候取消高亮
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- 添加是否启用 inlay hint 的快捷键，inlay hint 可以显示函数参数类型、参数名
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { 
          -- warning 与 error 都会波浪线提示
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
          }, 
        },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- 获取 Neovim 默认的 LSP 客户端功能。
      -- 合并 blink.cmp 及其可能依赖的其他插件（如 luasnip）所增加的新功能（例如对代码片段的完整支持）
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- servers 列表中的 lsp server 将被自动安装并启用
      -- cmd、filetypes、capabilities、root_markers 等选项可以覆盖 nvim-lspconfig 中的默认配置
      local servers = {
        stylua = {enabled = false},
        clangd = {},
        gopls = {},
        pyrefly = {},
        rust_analyzer = {},
        beancount = {},
        tinymist = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- 安装 servers 中定义的 lsp-server
      local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, { -- mason.nvim 中指定了
      --   'shfmt', -- Used to format Lua code
      -- })
      require('mason-lspconfig').setup {
        -- mason-lspconfig 调用 mason 安装其中的 lsp server
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            -- 将 client 的 lsp 功能与 server 的 lsp 功能深度合并
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}