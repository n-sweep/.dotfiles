-- automatically choose the appropriate venv if VIRTUAL_ENV or CONDA_PREFIX exists
local venv = os.getenv("VIRTUAL_ENV")

if venv ~= nil then
    venv = string.match(venv, "/.+/(.+)")
    vim.notify(venv .. ' found', vim.log.levels.INFO)
    vim.cmd(("MoltenInit %s"):format(venv))
else
    vim.notify('No environment found', vim.log.levels.INFO)
    vim.cmd("MoltenInit python3")
end
