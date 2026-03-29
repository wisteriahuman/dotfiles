return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")
      local tools = { "stylua", "biome", "ruff" }
      for _, tool in ipairs(tools) do
        if not registry.is_installed(tool) then
          registry.get_package(tool):install()
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "pyright",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "astro",
          "rust_analyzer",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("astro")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("sourcekit")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "swift",
        callback = function()
          local root = vim.fs.root(0, function(name)
            return name:match("%.xcodeproj$")
          end)
          if not root then
            return
          end
          local bsj = root .. "/buildServer.json"
          if vim.uv.fs_stat(bsj) then
            return
          end
          local xcodeproj = vim.fs.find(function(name)
            return name:match("%.xcodeproj$")
          end, { path = root, type = "directory" })[1]
          if xcodeproj then
            local project = vim.fn.fnamemodify(xcodeproj, ":t")
            local scheme = project:gsub("%.xcodeproj$", "")
            vim
              .system({
                "xcode-build-server",
                "config",
                "-project",
                project,
                "-scheme",
                scheme,
              }, { cwd = root })
              :wait()
            vim.notify("xcode-build-server configured: " .. scheme, vim.log.levels.INFO)
          end
        end,
      })
    end,
  },
}
