return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = "slant",
        },
      })

      local map = vim.keymap.set
      map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
      map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
      map("n", "<A-c>", "<cmd>BufferLinePickClose<CR>", { desc = "Close Buffer" })
    end,
  },
}
