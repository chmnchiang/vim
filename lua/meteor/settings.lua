local M = {}

local opt = {}

function M.set_opt(o)
  if o ~= nil then
    opt = o
  end
end

function M.get_opt()
  return opt
end

function M.is_dev()
  return opt.dev == true
end

function M.is_personal()
  return opt.personal == true
end

M.floating_window_border = {
  '🭽',
  '▔',
  '🭾',
  '▕',
  '🭿',
  '▁',
  '🭼',
  '▏',
}

return M
