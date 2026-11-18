local map = vim.keymap.set
local diag_pop_next = function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float(nil, { focus = false })
end
local diag_pop_prev = function()
	vim.diagnostic.goto_prev()
	vim.diagnostic.open_float(nil, { focus = false })
end

-- LSP → television pickers
-- Single result: jump directly. Multiple: write to the cache read by the
-- `lsp` tv channel (file\tline\tcol\ttext) and open it.
local lsp_results_file = vim.fn.expand("~/.cache/tv-lsp-results")

local function lsp_tv_picker(method, label)
	return function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr, method = method })
		if #clients == 0 then
			vim.notify("No LSP client supports " .. method, vim.log.levels.WARN)
			return
		end
		local encoding = clients[1].offset_encoding
		local params = vim.lsp.util.make_position_params(0, encoding)
		if method == "textDocument/references" then
			params.context = { includeDeclaration = true }
		end

		vim.lsp.buf_request_all(bufnr, method, params, function(results)
			local locations = {}
			for _, res in pairs(results) do
				local r = res.result
				if r then
					-- result can be a single Location or a list of Location/LocationLink
					if r.uri or r.targetUri then
						r = { r }
					end
					vim.list_extend(locations, r)
				end
			end

			vim.schedule(function()
				if #locations == 0 then
					vim.notify("No " .. label .. " found", vim.log.levels.INFO)
					return
				end
				if #locations == 1 then
					vim.lsp.util.show_document(locations[1], encoding, { focus = true })
					return
				end

				local lines = {}
				for _, item in ipairs(vim.lsp.util.locations_to_items(locations, encoding)) do
					local text = vim.trim((item.text or ""):gsub("\t", " "))
					table.insert(lines, table.concat({
						vim.fn.fnamemodify(item.filename, ":."),
						item.lnum,
						item.col,
						text,
					}, "\t"))
				end
				vim.fn.mkdir(vim.fn.fnamemodify(lsp_results_file, ":h"), "p")
				vim.fn.writefile(lines, lsp_results_file)
				require("tv").tv_channel("lsp")
			end)
		end)
	end
end

local lsp_ref_picker = lsp_tv_picker("textDocument/references", "references")
local lsp_def_picker = lsp_tv_picker("textDocument/definition", "definitions")
local lsp_type_def_picker = lsp_tv_picker("textDocument/typeDefinition", "type definitions")
local lsp_impl_picker = lsp_tv_picker("textDocument/implementation", "implementations")

-- Yazi
map("n", "<leader>-", "<cmd>Yazi<CR>")
map("n", "<leader>cwd", "<cmd>Yazi cwd<CR>")
map("n", "<C-up>", "<cmd>Yazi toggle<CR>")

-- Television
map("n", "<leader>ff", "<cmd>Tv files<CR>")
map("n", "<leader>fg", "<cmd>Tv text<CR>")
map("n", "<leader>todo", "<cmd>Tv todo-comments<CR>")
-- Television - GitHub
map("n", "<leader>gitis", "<cmd>Tv gh-issues<CR>")
map("n", "<leader>gitpr", "<cmd>Tv gh-prs<CR>")
-- Television - Git
map("n", "<leader>gitl", "<cmd>Tv git-log<CR>")
map("n", "<leader>gitd", "<cmd>Tv git-diff<CR>")
map("n", "<leader>gitwt", "<cmd>Tv git-worktrees<CR>")
map("n", "<leader>gitbr", "<cmd>Tv git-branch<CR>")
-- Television - Rust
map("n", "<leader>rc", "<cmd>Tv cargo-commands<CR>")
map("n", "<leader>rp", "<cmd>Tv rust-projects<CR>")
-- Television - Projects
map("n", "<leader>fp", "<cmd>Tv projects<CR>")

-- LSP
map("n", "<leader>r", vim.lsp.buf.rename) -- Exclusive !!
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "gr", lsp_ref_picker)
map("n", "gd", lsp_def_picker)
map("n", "gt", lsp_type_def_picker)
map("n", "gi", lsp_impl_picker)

-- LSP - Diagnostics
map("n", "]d", diag_pop_next)
map("n", "[d", diag_pop_prev)

-- LSP - Previews
map("n", "<C-s>", "<cmd>SymbolsToggle<CR>")
map("n", "<C-v>md", "<cmd>RenderMarkdown toggle<CR>")
map("n", "<C-v>ill", "<cmd>IlluminateToggleBuf<CR>")

-- Copy/Paste
map("n", "<C-y>", "\"+y")
map("n", "<C-p>", "\"+p")

-- Tabs
map("n", "<C-t>v", "<cmd>tabnew<CR>")
map("n", "<C-t>q", "<cmd>tabclose<CR>")
map("n", "<C-t>h", "<cmd>tabprevious<CR>")
map("n", "<C-t>l", "<cmd>tabnext<CR>")
map("n", "<C-t>tH", ":tabm -1<CR>")
map("n", "<C-t>tL", ":tabm +1<CR>")

-- Tab - Switch 1-10
for i = 1, 9 do
	map("n", string.format("<C-t>%d", i), string.format("<cmd>tabn %d<CR>", i))
end
map("n", "<C-t>0", "<cmd>tabn 10<CR>")
