--- Configuration for tt-coderunner
local config = {
    save_first = true,
    code_runner = {
        py = "python3",
        sh = "bash",
        lua = "lua",
    },
}

local M = {}

--- Get the path to the current file
--- @return (string | nil) file_path The path to the file
local function get_file_path()
    local file_path = vim.fn.expand("%:p")
    if not file_path or file_path == "" then
        vim.notify("No file is currently focused.", vim.log.levels.ERROR)
        return nil
    end
    return file_path
end

---@param file_path string The path to the file
---@param conf table The configuration for tt-coderunner
---@return (string | nil) command The command to run the file
local function get_run_command(file_path, conf)
    local extension = file_path:match("%.([^.]+)$")
    if conf.code_runner[extension] then
        return conf.code_runner[extension] .. " " .. file_path
    else
        vim.notify("Unsupported file type: " .. (extension or "unknown"), vim.log.levels.ERROR)
        return nil
    end
end

--- Run the current file in a specified terminal
---@param term_num number The terminal number to run the command in
---@param conf table The configuration for tt-coderunner
function M.run_in_terminal(term_num, conf)
    local file_path = get_file_path()
    if not file_path then
        return
    end

    -- Save the current buffer
    if conf.save_first then
        vim.cmd("w")
    end

    local command = get_run_command(file_path, conf)
    if not command then
        return
    end

    -- Use :<term_num>ToggleTerm to execute the command
    vim.cmd(term_num .. "ToggleTerm")
    vim.cmd("TermExec cmd='" .. command .. "'")
end

--- Run the current file in the last active terminal
--- @param conf table The configuration for tt-coderunner
function M.run_in_last_terminal(conf)
    local file_path = get_file_path()
    if not file_path then
        return
    end

    -- Save the current buffer
    if conf.save_first then
        vim.cmd("w")
    end

    local command = get_run_command(file_path, conf)
    if not command then
        return
    end

    -- Execute the command in the last active terminal
    vim.cmd("TermExec cmd='" .. command .. "'")
end

--- Set up the commands for tt-coderunner
---@param conf table The configuration for tt-coderunner
local function setup_commands(conf)
    local command = vim.api.nvim_create_user_command

    command("RunInTerminal", function(args)
        if args.count == 0 then
            M.run_in_last_terminal(conf)
        else
            M.run_in_terminal(args.count, conf)
        end
    end
    , { count = true, nargs = 0 })
end

local function set_config(user_conf)
    user_conf = user_conf or {}
    config = vim.tbl_deep_extend("force", config, user_conf)
    return config
end

function M.setup(user_config)
    -- Set the user configuration
    local conf = set_config(user_config) or config

    -- Ensure ToggleTerm is loaded
    local ok, _ = pcall(require, "toggleterm")
    if not ok then
        vim.notify("ToggleTerm is not installed or failed to load", vim.log.levels.ERROR)
        return
    end

    -- Setup plugin
    setup_commands(conf)
end

return M
