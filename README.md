# yasl.nvim

Yet another ***minimal and lightweight*** statusline plugin for neovim.

## Features
On top of vim's default statusline items, Yasl provides:

- Lsp diagnostics
- Git informations 
    - Branch name
    - Diff stats
- Active mode

with no extra dependencies.

It also evaluates each component only when needed to prevent frequent expensive function calls.

## Examples
![screenshot of statusline](./examples/screenshot.png)

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

## Configurations
### Provided components
- [mode](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/builtins/mode.lua)
- [diagnostics](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/builtins/diagnostics.lua)
- [branch](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/builtins/branch.lua)
- [gitdiff](https://github.com/brianaung/yasl.nvim/blob/main/lua/yasl/builtins/gitdiff.lua)
- Plus any string value vim can evaluate for statusline. See `:h statusline`.

### Default options
```lua
    -- default options

    -- Use global statusline. See :h laststatus
    global = true,

    --[[
    Accepts provided component name (or)
    any string vim can use for statusline value. See :h statusline

    Default layout:
    +---------------------------------------------------------------------+
    | mode | name |        | diagnostics | diff |       | ft | loc | prog |
    +---------------------------------------------------------------------+
    ]]--
    components = {
        "mode",
        " ",
        "%<%t%h%m%r%w", -- filename
        "branch",
        "%=",
        "diagnostics",
        "gitdiff",
        "%=",
        "%y %-8.(%l, %c%V%) %P", -- filetype, location, and progress
    }
```
