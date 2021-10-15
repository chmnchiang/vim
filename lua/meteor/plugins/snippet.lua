local M = {}

function M.setup(use)
	use {
		'SirVer/ultisnips',
		config = function()
			vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<S-tab>"
		end,
	}
	use {
		'honza/vim-snippets',
	}
end

return M
