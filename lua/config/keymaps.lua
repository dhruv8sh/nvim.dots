local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>")
map("n", "<leader>fem", "<cmd>Telescope emoji<CR>")
map("n", "<leader>fp", "<cmd>Telescope project<CR>")
map("n", "<leader>fs", "<cmd>Telescope aerial<CR>")

map("n", "<leader>tt", "<cmd>TodoTelescope<CR>")

map("n", "<leader>git", "<cmd>LazyGit<CR>")
map("n", "<leader>gitf", "<cmd>LazyGitCurrentFile<CR>")

map("n", "<leader>cc", "<cmd>CommentToggle<CR>")
map("n", "<leader>cs", "<cmd>CommentToggle<CR>")

map("n", "<leader>pv", "<cmd>Oil<CR>")

map("n", "<leader>peo", "<cmd>PeekOpen<CR>")
map("n", "<leader>pec", "<cmd>PeekClose<CR>")

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", builtin.lsp_references, { desc = "References" })
map("n", "gt", builtin.lsp_type_definitions, { desc = "Type Definitions" })
map("n", "gi", builtin.lsp_implementations, { desc = "Implementations" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
map("n", "<leader>y", "\"+y")
map("n", "<leader>p", "\"+p")

---- Tabs
map("n", "tn", ":tabnew<CR>")
map("n", "tc", ":tabclose<CR>")
map("n", "th", ":tabprevious<CR>")
map("n", "tl", ":tabnext<CR>")
map("n", "<leader>tH", ":tabm -1<CR>")
map("n", "<leader>tL", ":tabm +1<CR>")
for i = 1, 9 do
	map("n", string.format("tm%d", i), function()
		vim.cmd("tabn " .. i)
	end)
end

---- Buffers
map("n", "[b", ":bnext<CR>")
map("n", "[b", ":bprevious<CR>")

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Next diagnostic + float" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Prev diagnostic + float" })

vim.keymap.set("n", "[f", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics (current file)" })

vim.keymap.set("n", "[a", function()
	builtin.diagnostics()
end, { desc = "Diagnostics (workspace)" })
vim.keymap.set("n", "[ae", function()
	builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Errors only (workspace)" })

vim.keymap.set("n", "[aw", function()
	builtin.diagnostics({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Warnings only (workspace)" })

vim.keymap.set("n", "[ai", function()
	builtin.diagnostics({ severity = vim.diagnostic.severity.INFO })
end, { desc = "Info only (workspace)" })

vim.keymap.set("n", "[ah", function()
	builtin.diagnostics({ severity = vim.diagnostic.severity.HINT })
end, { desc = "Hints only (workspace)" })
