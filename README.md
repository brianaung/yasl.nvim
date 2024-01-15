# yasl.nvim

Yet another ***minimal and lightweight*** statusline plugin for neovim.

## Features
On top of vim's default statusline items, yasl provides:

- Lsp diagnostics
- Git informations such as branch name and diff stats.

without needing any extra dependencies.

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
**See [defaults](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/default.lua).**

**Enable/Disable global statusline.**
```lua
global = true, -- default
```

**All provided components.**
```lua
-- default sections
sections = {
    A = { components = { "mode" } },
    B = { components = { "diagnostics" } },
    C = { components = { "filename", "branch", "gitdiff" } },
    D = { components = { "filetype" } },
    E = { components = { "location", "progress" } },
}
```

**Using any statusline items that are available in vim but not provided by default.**
```lua
sections = {
    A = {
        components = { 
            -- use provided `mode` component
            "mode", 
            -- pass a function that return any statusline item provided by vim. 
            -- see h: statusline
            function()
                return "%n" 
            end
        } 
    },
    ...
}
```

**Leaving a section table, or its components table empty will hide that particular section.**
```lua
-- section A and B will be empty
sections = {
    A = {},
    B = { components = {} },
    ...
}
```

**Passing an empty table to `sections` will result in an empty statusline.**
```lua
sections = {}
```

**You can also pass in custom highlights to each section.**
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
