local vim = vim
local M = {}
local job_id = nil

function M.start_server()
    if job_id then
        print('Server is already running')
    else
        local path = debug.getinfo(1, 'S').source:sub(2)
        local dir = path:match('(.*/)')

        job_id = vim.fn.jobstart(
            'python ' .. dir .. '/server/run_flask.py',
            { on_exit = function() print('Server exited'); job_id = nil end }
        )
        print('Server started')
    end
end

function M.stop_server()
    if job_id then
        vim.fn.jobstop(job_id)
        print('Stopped server')
    else
        print('Server is not running')
    end
end

return M
