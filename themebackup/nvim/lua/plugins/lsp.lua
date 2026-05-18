return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()

      -- keybindings when LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd",         vim.lsp.buf.definition,     "Go to definition")
          map("gD",         vim.lsp.buf.declaration,    "Go to declaration")
          map("gr",         vim.lsp.buf.references,     "References")
          map("gi",         vim.lsp.buf.implementation, "Go to implementation")
          map("K",          vim.lsp.buf.hover,          "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
          map("<leader>f",  vim.lsp.buf.format,         "Format file")
          map("[d",         vim.diagnostic.goto_prev,   "Previous diagnostic")
          map("]d",         vim.diagnostic.goto_next,   "Next diagnostic")
          map("<leader>d",  vim.diagnostic.open_float,  "Show diagnostic")
        end,
      })

      -- new way of configuring servers in nvim-lspconfig 0.11+
      vim.lsp.config("*", {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "ts_ls",
        "rust_analyzer",
      })

    end,
  },
}
