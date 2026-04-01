return {
  {
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    opts = {
      sections = {
        definition = false,
        references = function(count)
          return "参照: " .. count
        end,
        implements = function(count)
          return "実装: " .. count
        end,
        git_authors = function(latest_author, count)
          return "著者: " .. latest_author .. (count - 1 == 0 and "" or (" 他" .. (count - 1) .. "人"))
        end,
      },
      ignore_filetype = {
        "prisma",
        "markdown",
        "text",
        "json",
        "yaml",
        "toml",
      },
    },
    keys = {
      { "<leader>uL", "<cmd>LspLensToggle<CR>", desc = "Toggle LSP Lens" },
    },
  },
}
