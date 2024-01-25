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
- Your own component. See [recipe](#recipe-for-creating-your-own-component)
- Plus any string value vim can evaluate for statusline. See `:h statusline`.

### Default options
```lua
require("yasl").setup({
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
		" ",
		"branch",
		" ",
		"diagnostics",
		"%=",
		"gitdiff",
		" ",
		"%y",
		" ",
		"[%-8.(%l, %c%V%) %P]", -- filetype, location, and progress
		" ",
	}
})
```

### Recipe for creating your own component
To provide your own custom components, simply pass in a table to `components` array
with values for `events` and `update` set.

```lua
require("yasl").setup({
    ...
    components = {
        ...
        {
            -- Events that will trigger update function calls and redraws the statusline.
            events = { "BufEnter" },
            -- Any function that returns a string value.
            update = function()
                return "Hello!"
            end
        },
        ...
    },
    ...
})
```
