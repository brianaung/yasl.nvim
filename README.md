# yasl.nvim

Yet another ***minimal and lightweight*** statusline plugin for neovim.

## Examples
![screenshot of statusline with custom colors](./examples/screenshot1.png)

## Installation
Using Lazy:
```lua
{
    "brianaung/yasl.nvim",
    config = function()
        require("yasl").setup() -- call this to enable plugin
    end
}
```

## Configuration
### Sections layout
```
+------------------------------------+
| A | B |        | C |       | D | E |
+------------------------------------+
```

### Configuration
See [defaults](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/default.lua).

Example configuration:
```lua
require("yasl").setup({
    global = true, -- sets laststatus 3, false sets it to 2
    -- example sections with all available modules
    sections = {
        A = { components = { "mode" } },
        B = { components = { "diagnostics" } },
        C = { components = { "filename", "branch", "gitdiff" } },
        D = { components = { "filetype" } },
        E = { components = { "location", "progress" } },
    }
})
```

Leaving a section table, or its components table empty will hide that particular section.
```lua
-- section a and b will be empty
sections = {
    A = {},
    B = { components = {} },
    ...
}
```

Passing an empty table to `sections` will result in an empty statusline.
```lua
sections = {}
```

You can also pass in custom highlights to each section.
```lua
-- provide custom highlights
sections = {
    -- see :h nvim_set_hl() to see the {val} format
    A = { 
        components = { "mode" }, 
        highlight = { fg = "#202020", bg = "#7daea3" },
    },
    ...
}
```
