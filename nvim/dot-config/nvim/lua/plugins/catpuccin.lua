local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    color_overrides = {
      mocha = { -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-8891843
        rosewater = "#FB4834",
        flamingo = "#FB4834",
        red = "#FB4834",
        maroon = "#FB4834",
        pink = "#d3859b",
        mauve = "#d3859b",
        peach = "#e78a4e",
        yellow = "#FBBD2E",
        green = "#8dc07c",
        teal = "#B9BB25",
        sky = "#99c792",
        sapphire = "#99c792",
        blue = "#8dbba3",
        lavender = "#8dbba3",
        text = "#f1e4c2",
        subtext2 = "#c5b4a1",
        subtext1 = "#d5c4a1",
        subtext0 = "#bdae93",
        overlay2 = "#a89984",
        overlay1 = "#928374",
        overlay0 = "#595959",
        surface2 = "#4d4d4d",
        surface1 = "#404040",
        surface0 = "#292929",
        base = "#1d2224",
        mantle = "#1d2224",
        crust = "#1f2223",
      },
    },
    transparent_background = true,
    integrations = {
      blink_cmp = true,
      mini = {
        enabled = true,
      },
      neotree = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      treesitter = true,
      telescope = {
        enabled = true,
      },
    },
  },
}

return { M }
