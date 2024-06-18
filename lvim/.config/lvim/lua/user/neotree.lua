require("neo-tree").setup({
  default_component_configs = {
    git_status = {
      symbols = {
      -- Change type
      added     = "✚",
      deleted   = "✖",
      modified  = "",
      renamed   = "󰁕",
      -- Status type
      untracked = "",
      ignored   = "",
      unstaged  = "󰜺",
      staged    = "",
      conflict  = "",
      }
    }
  },
  close_if_last_window = true,
  window = {
    width = 30,
  },
  buffers = {
    follow_current_file = { enabled = true },
  },
  filesystem = {
    follow_current_file = { enabled = true },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "node_modules"
      },
      never_show = {
        ".DS_Store",
        "thumbs.db"
      },
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
      -- auto close
      -- vimc.cmd("Neotree close")
      -- OR
      require("neo-tree.command").execute({ action = "close" })
      end
    },
  },
})
