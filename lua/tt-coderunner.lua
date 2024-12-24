local config = {
    save_first = true,
}

local M = {}


local function get_file_path()
    local file_path = vim.fn.expand("%:p")
    if not file_path or file_path == "" then
        vim.notify("No file is currently focused.", vim.log.levels.ERROR)
        return nil
    end
    return file_path
end

local function get_run_command(file_path)
    local extension = file_path:match("%.([^.]+)$")
    if extension == "py" then
        return "python3 " .. file_path
    elseif extension == "sh" then
        return "bash " .. file_path
    else
        vim.notify("Unsupported file type: " .. (extension or "unknown"), vim.log.levels.ERROR)
        return nil
    end
end

function M.run_in_terminal(term_num, save_first)
    local file_path = get_file_path()
    if not file_path then
        return
    end

    -- Save the current buffer
    if save_first then
        vim.cmd("w")
    end

    local command = get_run_command(file_path)
    if not command then
        return
    end

    -- Use :<term_num>ToggleTerm to execute the command
    vim.cmd(term_num .. "ToggleTerm")
    vim.cmd("TermExec cmd='" .. command .. "'")
end

function M.run_in_last_terminal(save_first)
    local file_path = get_file_path()
    if not file_path then
        return
    end

    -- Save the current buffer
    if save_first then
        vim.cmd("w")
    end

    local command = get_run_command(file_path)
    if not command then
        return
    end

    -- Execute the command in the last active terminal
    vim.cmd("TermExec cmd='" .. command .. "'")
end

local function setup_commands(conf)
    local command = vim.api.nvim_create_user_command

    command("RunInTerminal", function(args)
        if args.count == 0 then
            M.run_in_last_terminal(conf.save_first)
        else
            M.run_in_terminal(args.count, conf.save_first)
        end
    end
    , { count = true, nargs = 0 })
end

function M.setup(user_config)
    -- Set the user configuration
    local conf = config.set(user_config)

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
