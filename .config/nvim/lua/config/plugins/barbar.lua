return {
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup()

      local map = vim.keymap.set
      map("n", "<A-,>", "<cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
      map("n", "<A-.>", "<cmd>BufferNext<CR>", { desc = "Next Buffer" })
      map("n", "<A-c>", "<cmd>BufferClose<CR>", { desc = "Close Buffer" })
    end,
  },
}
