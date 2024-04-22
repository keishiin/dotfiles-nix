return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    event = "VeryLazy",
    opts = {
      no_underline = true,
      show_end_of_buffer = true,
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      news = { lazyvim = false },
      colorscheme = "catppuccin",
    },
  },
}
