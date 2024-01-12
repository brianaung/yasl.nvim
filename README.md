# yasl.nvim

Yet another (minimal and lightweight) statusline plugin for neovim.

## Installation
Using Lazy:
```lua
{
    "brianaung/yasl.nvim",
    config = function()
        require("yasl").setup()
    end
}
```

## Configuration
```lua
require("yasl").setup({
    -- default options
    sections = {
        a = { components = { "mode" } },
        b = { components = { "diagnostics" } },
        c = { components = { "filename", "branch" } },
        d = { components = { "filetype" } },
        e = { components = { "location", "progress" } },
    }
})
```

***WIP***
