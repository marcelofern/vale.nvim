# Vale

A Neovim wrapper around Vale, the syntax-aware linter for prose.

**NOTE**: This is a beta version, please add an issue if you see any errors!

![demo](static/vale_demo.gif)

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'marcelofern/vale.nvim'
```

Using [dein](https://github.com/Shougo/dein.vim)

```viml
call dein#add('marcelofern/vale.nvim')
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'marcelofern/vale.nvim'
}
```

## Configuration

```lua
require("vale").setup({
  -- path to the vale binary.
  bin="/bin/vale",
  -- path to your vale-specific configuration.
  vale_config_path="$HOME/.config/vale/vale.ini",
})
```

## Requirements

[Neovim (v0.7.0)](https://github.com/neovim/neovim/releases/tag/v0.7.0) or the
latest neovim nightly commit is required for `vale.nvim` to work.

## Don't know what Vale is and how to configure it?

Instructions to install and configure Vale go as follows:

1. Head down to Vale's [Github page](https://github.com/errata-ai/vale).
2. From the [releases page](https://github.com/errata-ai/vale/releases),
   download and install the most adequate binary for your system.
3. Go to the [Config Generator](https://vale.sh/generator) website to select
   the configuration you want to use.
4. Run `vale sync` so that all the necessary packages are installed.

Enjoy!
