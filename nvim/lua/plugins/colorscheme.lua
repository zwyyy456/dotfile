return {
  -- add gruvbox
  { 
    "ellisonleao/gruvbox.nvim",
    priority = 100,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end
  },
}
