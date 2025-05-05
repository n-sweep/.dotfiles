-- automatically choose the appropriate venv if VIRTUAL_ENV or CONDA_PREFIX exists
local venv = os.getenv("VIRTUAL_ENV")

if venv ~= nil then
    venv = string.match(venv, "/.+/(.+)")
    print(venv .. ' found')
    vim.cmd(("MoltenInit %s"):format(venv))
else
    print('No environment found')
    vim.cmd("MoltenInit python3")
end
