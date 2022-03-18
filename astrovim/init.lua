local config = {
	plugins = {
		packer = {
			compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		},
	},

	-- On/off virtual diagnostics text
	diagnostics = {
		virtual_text = true,
	},

	-- Disable default plugins
	enabled = {
		bufferline = true,
		nvim_tree = true,
		lualine = true,
		lspsaga = true,
		gitsigns = true,
		colorizer = true,
		toggle_term = true,
		comment = true,
		symbols_outline = true,
		indent_blankline = true,
		dashboard = true,
		which_key = true,
		neoscroll = true,
		ts_rainbow = true,
		ts_autotag = true,
	},

	polish = function()
		local opts = { noremap = true, silent = true }
		local set = vim.opt

		local map = function(mode, shortcut, command)
			vim.api.nvim_set_keymap(mode, shortcut, command, opts)
		end
		local _map = function(shortcut, command)
			vim.api.nvim_set_keymap("", shortcut, command, {})
		end
		local nmap = function(shortcut, command)
			map("n", shortcut, command)
		end
		local vmap = function(shortcut, command)
			map("v", shortcut, command)
		end
		local imap = function(shortcut, command)
			map("i", shortcut, command)
		end
		local xmap = function(shortcut, command)
			map("x", shortcut, command)
		end
		local tmap = function(shortcut, command)
			map("t", shortcut, command)
		end
		local noremap = function(mode, shortcut, command)
			vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true })
		end
		-- No remap for all modes
		local _noremap = function(shortcut, command)
			vim.api.nvim_set_keymap("", shortcut, command, { noremap = true })
		end

		local unmap = function(mode, shortcut)
			vim.api.nvim_del_keymap(mode, shortcut)
		end
		local nunmap = function(shortcut)
			unmap("n", shortcut)
		end
		local vunmap = function(shortcut)
			unmap("v", shortcut)
		end

		-- Set options
		set.relativenumber = true

		-- Set key bindings
		nmap("<C-s>", ":w!<CR>", opts)

		--  ; as :
		noremap("n", ";", ":")

		-- Use Ctrl+C to go back to normal mode
		_noremap("<C-c>", "<Esc>")

		-- Buffer nav with Tab
		noremap("n", "<Tab>", ":bn<CR>")
		noremap("n", "<S-Tab>", ":bp<CR>")

		vim.cmd([[
       autocmd! TermMappings
    ]])

		-- terminal mappings
		tmap("<Leader><esc>", "<c-\\><c-n>")
		tmap("<Esc><esc>", "<c-\\><c-n>:ToggleTerm<CR>")
		tmap("<c-h>", "<c-\\><c-n><c-w>h")
		tmap("<c-j>", "<c-\\><c-n><c-w>j")
		tmap("<c-k>", "<c-\\><c-n><c-w>k")
		tmap("<c-l>", "<c-\\><c-n><c-w>l")

		-- Set autocommands
		-- vim.cmd [[
		--   augroup packer_conf
		--     autocmd!
		--     autocmd bufwritepost plugins.lua source <afile> | PackerSync
		--   augroup end
		-- ]]
	end,
}

return config
