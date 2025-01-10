return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter" },
}
