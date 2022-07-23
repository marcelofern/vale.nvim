# Vale

A Neovim wrapper around Vale, the syntax-aware linter for prose.

**NOTE**: This is a beta version, please add an issue if you see any errors!

![demo](static/vale_demo.gif)

## Configuration

```vimscript
lua << EOF
require("vale").setup({
  -- path to the vale binary.
  bin="/bin/vale",
  -- path to your vale-specific configuration.
  vale_config_path="$HOME/.config/vale/vale.ini",
})
EOF
})
```
