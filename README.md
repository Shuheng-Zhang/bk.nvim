# bk.nvim

Read **_ePub_** file in Neovim!!!

# Project Status

Currently working in progress...

# Dependencies

1. `cargo`: Rust package manager, for installing `bk`
2. `bk`: TUI ePub reader

Run the command below to install `bk`:

```bash

cargo install bk

```

# Installation

Install this plugin via `lazy.nvim`:

```lua
{
  "Shuheng-Zhang/bk.nvim",
  lazy = false,
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-telescope/telescope.nvim"
  },
  opts = {
		window = {
			size = {
        -- if width or height is less then 1
        -- that will use precentage relative editor width and height
				width = 80,
				height = 5,
			},
      -- BOTTOM_LEFT
      -- BOTTOM_CENTER
			position = "BOTTOM_RIGHT",
		},
    -- store recent reading file paths
		recent = true,
  },
  keys = {
    { "<leader>pe",
      function()
        vim.ui.input({ prompt= "ePub path" }, function(input)
          if input then
            vim.cmd("BkReader " .. input)
          end
        end)
      end,
      desc = "Open epub reader"
    },
		{
			"<leader>pE",
			"<cmd>Telescope bk_telescope<CR>",
			desc = "Open epub Reader form recently",
		},
  }

}
```

# commands

This plugin provides commands below:

- `BkReader <path/to/epub/file>`: open the reader with the given file path
- `Telescope bk_telescope`: select recently read file by Telescope and open the reader
- `BkRecentClear`: Clear recently read

# Special Thanks

[bk](https://github.com/aeosynth/bk) - A TUI application for reading ePub in termianl written in Rust
