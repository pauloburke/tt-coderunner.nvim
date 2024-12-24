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
wk.add({
    { "<leader>r",  group = "Code Runner" },
    { "<leader>rr", ":RunInTerminal<CR>",  desc = "Run Code" },
    { "<leader>r1", ":1RunInTerminal<CR>", desc = "Run Code in Terminal 1" },
    { "<leader>r2", ":2RunInTerminal<CR>", desc = "Run Code in Terminal 2" },
    { "<leader>r3", ":3RunInTerminal<CR>", desc = "Run Code in Terminal 3" },
    { "<leader>r4", ":4RunInTerminal<CR>", desc = "Run Code in Terminal 4" },
    { "<leader>r5", ":5RunInTerminal<CR>", desc = "Run Code in Terminal 5" },
})
```
