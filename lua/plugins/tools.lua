return {
  {
    "vim-test/vim-test",
  },

  -- image viewer
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-lua/popup.nvim",
      },
    },
    opts = {
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
      },
    },
  },
}
