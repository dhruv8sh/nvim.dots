return {
	"alexpasmantier/tv.nvim",
	config = function()
		local tv = require("tv")
		local h = tv.handlers
		function h.cd(entries, config)
			if #entries == 0 then
				vim.cmd("cd")
				return
			end
			local dir = vim.fn.trim(entries[1])
			if vim.fn.isdirectory(dir) == 1 then
				vim.cmd("cd " .. vim.fn.fnameescape(dir))
				vim.notify("Changed directory to: " .. dir, vim.log.levels.INFO, { title = "tv.nvim" })
			end
		end

		-- ── Project list ─────────────────────────────────────────────
		local projects_file = (vim.env.XDG_DATA_HOME or (vim.env.HOME .. "/.local/share")) .. "/tv/projects"

		local function read_projects()
			if vim.fn.filereadable(projects_file) == 0 then
				return {}
			end
			return vim.fn.readfile(projects_file)
		end

		local function write_projects(list)
			vim.fn.mkdir(vim.fn.fnamemodify(projects_file, ":h"), "p")
			vim.fn.writefile(list, projects_file)
		end

		local function project_root(path)
			path = path or vim.fn.getcwd()
			local root = vim.fs.root(path, { ".git", "Cargo.toml", "package.json", "go.mod", "pyproject.toml", "Makefile" })
			return vim.fs.normalize(root or path)
		end

		--- Add a directory (default: current project root) to the list.
		local function project_add(dir)
			dir = vim.fs.normalize(vim.fn.fnamemodify(dir or project_root(), ":p")):gsub("/$", "")
			local list = read_projects()
			if vim.tbl_contains(list, dir) then
				vim.notify("Already a project: " .. dir, vim.log.levels.WARN, { title = "tv.nvim" })
				return
			end
			table.insert(list, dir)
			table.sort(list)
			write_projects(list)
			vim.notify("Added project: " .. dir, vim.log.levels.INFO, { title = "tv.nvim" })
		end

		--- Remove directories from the list.
		local function project_remove(dirs)
			local drop = {}
			for _, d in ipairs(dirs) do
				drop[vim.fn.trim(d)] = true
			end
			local kept = vim.tbl_filter(function(d) return not drop[d] end, read_projects())
			write_projects(kept)
			vim.notify("Removed " .. vim.tbl_count(drop) .. " project(s)", vim.log.levels.INFO, { title = "tv.nvim" })
		end

		--- Drop entries whose directory no longer exists.
		local function project_prune()
			local list = read_projects()
			local kept = vim.tbl_filter(function(d) return vim.fn.isdirectory(d) == 1 end, list)
			write_projects(kept)
			vim.notify("Pruned " .. (#list - #kept) .. " missing project(s)", vim.log.levels.INFO, { title = "tv.nvim" })
		end

		-- Handlers
		function h.tcd(entries)
			local dir = entries[1] and vim.fn.trim(entries[1])
			if dir and vim.fn.isdirectory(dir) == 1 then
				vim.cmd("tabnew | tcd " .. vim.fn.fnameescape(dir))
			end
		end

		function h.cd_and_find(entries)
			h.cd(entries)
			if #entries > 0 then
				vim.schedule(function() vim.cmd("Tv files") end)
			end
		end

		function h.project_remove(entries)
			project_remove(entries)
		end

		function h.open_dir(entries)
			local dir = entries[1] and vim.fn.trim(entries[1])
			if dir then
				vim.cmd("edit " .. vim.fn.fnameescape(dir))
			end
		end

		vim.api.nvim_create_user_command("ProjectAdd", function(o)
			project_add(o.args ~= "" and o.args or nil)
		end, { nargs = "?", complete = "dir", desc = "Add project to tv list" })
		vim.api.nvim_create_user_command("ProjectRemove", function(o)
			project_remove({ o.args ~= "" and o.args or project_root() })
		end, { nargs = "?", complete = "dir", desc = "Remove project from tv list" })
		vim.api.nvim_create_user_command("ProjectPrune", project_prune, { desc = "Prune missing projects" })
		vim.api.nvim_create_user_command("ProjectEdit", function()
			vim.cmd("edit " .. vim.fn.fnameescape(projects_file))
		end, { desc = "Edit tv project list" })

		tv.setup({
			layout = "landscape",
			window = {
				width = 0.8, -- 80% of editor width
				height = 0.8, -- 80% of editor height
				border = "rounded",
				title = " tv.nvim ",
				title_pos = "center",
			},
			channels = {
				files = {
					layout = "portrait",
					args = { "--no-status-bar", "--preview-size", "70" },
					handlers = {
						["<CR>"] = h.open_as_files, -- default: open selected files
						["<C-q>"] = h.send_to_quickfix, -- send to quickfix list
						["<C-s>"] = h.open_in_split, -- open in horizontal split
						["<C-v>"] = h.open_in_vsplit, -- open in vertical split
						["<C-y>"] = h.copy_to_clipboard, -- copy paths to clipboard
					},
				},

				text = {
					handlers = {
						["<CR>"] = h.open_at_line,
						["<C-q>"] = h.send_to_quickfix,
						["<C-s>"] = h.open_in_split,
						["<C-v>"] = h.open_in_vsplit,
						["<C-y>"] = h.copy_to_clipboard,
					},
				},

				["git-log"] = {
					handlers = {
						["<CR>"] = function(entries, config)
							if #entries > 0 then
								vim.cmd("enew | setlocal buftype=nofile bufhidden=wipe")
								vim.cmd("silent 0read !git show " .. vim.fn.shellescape(entries[1]))
								vim.cmd("1delete _ | setlocal filetype=git nomodifiable")
								vim.cmd("normal! gg")
							end
						end,
						["<C-y>"] = h.copy_to_clipboard,
					},
				},

				["git-branch"] = {
					handlers = {
						["<CR>"] = h.execute_shell_command("git checkout {}"),
						["<C-y>"] = h.copy_to_clipboard,
					},
				},

				["git-issues"] = {
					handlers = {
						-- 				  ["<CR>"] = h.open,
						-- 				  ["<C-y>"] = h.close,
						-- 				  ["e"] = h.comment,
					},
				},
				["rust-projects"] = {
					handlers = {
						["<CR>"] = h.cd,
						["<C-t>"] = h.tcd,
					}
				},
				projects = {
					handlers = {
						["<CR>"] = h.cd, -- cd into project
						["<C-f>"] = h.cd_and_find, -- cd, then pick a file
						["<C-t>"] = h.tcd, -- new tab with tab-local cwd
						["<C-o>"] = h.open_dir, -- open dir in file explorer
						["<C-d>"] = h.project_remove, -- remove from list
						["<C-y>"] = h.copy_to_clipboard,
					},
				},
				lsp = {
					handlers = {
						["<CR>"] = h.open_at_line,
						["<C-q>"] = h.send_to_quickfix,
						["<C-y>"] = h.copy_to_clipboard,
					},
				},
			},
			tv_binary = "tv",
			global_keybindings = {
			},
			quickfix = {
				auto_open = true,
			},
		})
	end,
}
