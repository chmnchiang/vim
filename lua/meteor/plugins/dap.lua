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
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
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
    callback({ type = 'server', host = config.host, port = config.port })
  end

  vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition' })
  vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected' })
  vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint' })
  vim.fn.sign_define('DapStopped', {
    text = ' ',
    texthl = 'DapStopped',
    linehl = 'DapStoppedLine',
  })
end

local function dap_ui_config()
  local dapui = require('dapui')
  local dap = require('dap')
  dapui.setup({})
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open({})
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close({})
  end
end

local function dap_python_config()
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
end

function M.packages(opt)
  return {
    { 'mfussenegger/nvim-dap', config = dap_config },
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = { 'mfussenegger/nvim-dap' },
      opts = {},
    },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap' },
      config = dap_ui_config,
      keys = function()
        local dap = require('dap')
        return {
          { '<leader>dt', dap.toggle_breakpoint, desc = 'DAP toggle breakpoint' },
          { '<leader>dc', dap.continue, desc = 'DAP continue' },
          { '<leader>ds', dap.step_over, desc = 'DAP step over' },
          { '<leader>di', dap.step_into, desc = 'DAP step into' },
          { '<leader>do', dap.step_out, desc = 'DAP step out' },
          { '<leader>du', dap.up, desc = 'DAP go up a frame' },
          { '<leader>dd', dap.down, desc = 'DAP go down a frame' },
          { '<leader>dC', dap.run_to_cursor, desc = 'DAP run to cursor position' },
          { '<leader>de', require('dapui').eval, 'DAP eval expression under cursor' },
        }
      end,
    },
    {
      'mfussenegger/nvim-dap-python',
      ft = 'python',
      config = dap_python_config,
    },
    { 'jbyuki/one-small-step-for-vimkind', ft = 'lua' },
  }
end

return M
