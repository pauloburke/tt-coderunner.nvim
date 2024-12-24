# tt-coderunner.nvim
A simple neovim code executor using Toggle Term

It takes the current buffer and runs it in a Toggle Term window.

## Installation
Lazy:
```lua
{
    'tt-coderunner.nvim',
    dependencies = {"akinsho/toggleterm.nvim"}
    opts = {
        save_first = true, -- Save the file before running
        code_runner = {
            -- A mapping of filetypes to their respective interpreters
            py = "python3",
            lua = "lua",
            sh = "bash",
            -- Add more filetypes and their interpreters here
        }
    },
    config = true,
}
```

## Usage

`:RunInTerminal` to run the current buffer in a Toggle Term window.

`:#RunInTerminal` to run the current buffer in the # Toggle Term window. Substitute # with the window number.


## Suggested Mappings
```lua
vim.api.nvim_set_keymap('n', '<leader>rr', ':RunInTerminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r1', ':1RunInTerminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r2', ':2RunInTerminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r3', ':3RunInTerminal<CR>', { noremap = true, silent = true })
...
```

Using `which-key`:
```lua
local wk = require("which-key")
wk.register({
    ["<leader>r"] = {
        name = "Code[r]unner",
        r = {":RunInTerminal<CR>", "Run in Terminal"},
        ["1"] = {":1RunInTerminal<CR>", "Run in Terminal 1"},
        ["2"] = {":2RunInTerminal<CR>", "Run in Terminal 2"},
        ["3"] = {":3RunInTerminal<CR>", "Run in Terminal 3"},
        ...
    }
})
```

