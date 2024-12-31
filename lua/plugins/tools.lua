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

  -- git-conflict
  { "akinsho/git-conflict.nvim", version = "*", config = true },

  -- codeium
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-a>",
          clear_suggestion = "<C-]>",
          accept_word = "<A-a>",
        },
        ignore_filetypes = { "cpp", "json" }, -- or { "cpp", }
        color = {
          cterm = 244,
          suggestion_color = "#C8A2C8",
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return false
        end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      })
    end,
  },
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = {
      {
        "junegunn/fzf",
        build = "./install --bin",
      },
    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      keymaps = {
        ["<C-j>"] = true,
        ["<C-k>"] = false,
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
