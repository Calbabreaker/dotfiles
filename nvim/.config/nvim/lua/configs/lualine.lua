local lualine = require("lualine")

local lsp_status = require("lsp-status")

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function clients()
	local client_id_to_name = {}
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		if client.name ~= "null-ls" then
			client_id_to_name[client.id] = client.name
		end
	end

	local status_list = {}

	-- client messages
	for _, msg in ipairs(lsp_status.messages()) do
		-- msg.name is actually the id
		local client_name = client_id_to_name[msg.name]
		if client_name and msg.progress then
			local status = client_name .. ": " .. msg.title

			if msg.spinner then
				status = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. " " .. status
			end
			if msg.message then
				status = status .. " " .. msg.message
			end
			if msg.percentage then
				status = status .. string.format(" (%.0f%%%%)", msg.percentage)
			end

			-- make sure to not have multiple messages at once
			client_id_to_name[msg.name] = nil
			table.insert(status_list, status)
		end
	end

	-- insert rest of clients that don't have messages
	for _, name in pairs(client_id_to_name) do
		table.insert(status_list, name)
	end

	-- add null-ls linter and formatter clients
	if NullLSGetAvail then
		local null_ls_sources = NullLSGetAvail(vim.bo.filetype)
		if null_ls_sources then
			vim.list_extend(status_list, null_ls_sources)
		end
	end

	local statuses = "Inactive"
	if #status_list ~= 0 then
		statuses = table.concat(status_list, ", ")
	end

	return "  " .. statuses
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
}

local diff = {
	"diff",
	symbols = { added = " ", modified = "柳", removed = " " },
}

local branch = {
	"branch",
	icon = "",
}

lualine.setup({
	options = {
		theme = "onedark",
		disabled_filetypes = { "NvimTree", "packer", "dashboard" },
		section_separators = { left = "", right = "" },
		component_separators = { left = "│", right = "│" },
	},
	sections = {
		lualine_b = { branch },
		lualine_c = { "filename", diff },
		lualine_x = { diagnostics, clients },
		lualine_y = { "filetype" },
		lualine_z = { "%l:%c", "progress" },
	},
})
