return function(plugins)
  local my_plugins = {
    { "andymass/vim-matchup" },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup {
          transparent_background = true,
          term_colors = false,
          styles = {
            comments = "italic",
            functions = "italic",
            keywords = "italic",
            strings = "NONE",
            variables = "italic",
          },
          integrations = {
            treesitter = true,
            native_lsp = {
              enabled = true,
              virtual_text = {
                errors = "italic",
                hints = "italic",
                warnings = "italic",
                information = "italic",
              },
              underlines = {
                errors = "underline",
                hints = "underline",
                warnings = "underline",
                information = "underline",
              },
            },
            lsp_trouble = false,
            cmp = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = {
              enabled = true,
              show_root = false,
              transparent_panel = false,
            },
            neotree = {
              enabled = false,
              show_root = true,
              transparent_panel = true,
            },
            which_key = true,
            indent_blankline = {
              enabled = true,
              colored_indent_levels = false,
            },
            dashboard = false,
            neogit = true,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = true,
            markdown = true,
            lightspeed = false,
            ts_rainbow = true,
            hop = true,
            notify = false,
          },
        }
      end,
    },
    {
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup {
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
          lastplace_open_folds = true,
        }
      end,
    },
    {
      "alexghergh/nvim-tmux-navigation",
      config = function()
        require("nvim-tmux-navigation").setup {
          disable_when_zoomed = true, -- defaults to false
          keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>",
          },
        }
      end,
    },
  }

  -- Disabled Default Lazy Loading
  plugins["akinsho/nvim-toggleterm.lua"]["cmd"] = nil
  plugins["nvim-telescope/telescope.nvim"]["cmd"] = nil
  plugins["nvim-treesitter/nvim-treesitter"]["cmd"] = nil
  plugins["nvim-treesitter/nvim-treesitter"]["event"] = nil

  return vim.tbl_deep_extend("force", plugins, my_plugins)
end
