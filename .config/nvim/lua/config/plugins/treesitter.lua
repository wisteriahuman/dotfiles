return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      vim.treesitter.language.add('lua')
      require('nvim-treesitter').setup({
        ensure_installed = {
          'lua', 'go', 'python', 'typescript', 'javascript',
          'tsx', 'html', 'css', 'json', 'bash',
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
