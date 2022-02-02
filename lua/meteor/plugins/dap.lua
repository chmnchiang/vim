local M = {}

local function dap_config()
  local dap = require('dap')
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
            'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = 'Attach to running Neovim instance',
      host = function()
        local value = vim.fn.input('Host [127.0.0.1]: ')
        if value ~= '' then
          return value
        end
        return '127.0.0.1'
      end,
      port = function()
        local val = tonumber(vim.fn.input('Port: '))
        assert(val, 'Please provide a port number')
        return val
      end,
    },
  }
  dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
  end
end

local function dap_ui_config()
  local dapui = require('dapui')
  dapui.setup {}
end

local function dap_python_config()
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
end

function M.setup(use)
  use {'mfussenegger/nvim-dap', config = dap_config, module = 'dap'}
  use {
    'rcarriga/nvim-dap-ui',
    requires = {'mfussenegger/nvim-dap'},
    config = dap_ui_config,
    module = 'dapui',
    after = 'nvim-dap',
  }
  use {
    'mfussenegger/nvim-dap-python',
    after = 'nvim-dap',
    config = dap_python_config,
  }
  use {'jbyuki/one-small-step-for-vimkind', after = 'nvim-dap'}
end

return M
