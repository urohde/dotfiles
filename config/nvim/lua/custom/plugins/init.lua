-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	{ "nvim-neotest/nvim-nio" },
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"github/copilot.vim",
	},
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", "<cmd>G<cr>", desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
		},
	},
	{
		"tpope/vim-surround",
	},
	{
		"seblyng/roslyn.nvim",
		ft = { "cs" },
		opts = {},
	},
	{
		"ramboe/ramboe-dotnet-utils",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", {
				text = "🛑",
				texthl = "Error",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🔵",
				texthl = "WarningMsg",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapLogPoint", {
				text = "📄",
				texthl = "Question",
				linehl = "",
				numhl = "",
			})

			local netcoredbg_adapter = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.adapters.netcoredbg = netcoredbg_adapter
			dap.adapters.coreclr = netcoredbg_adapter

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch - netcoredbg",
					request = "launch",
					program = function()
						return require("dap-dll-autopicker").build_dll_path()
					end,
					env = {
						ASPNETCORE_ENVIRONMENT = function()
							return "Development"
						end,
					},
					cwd = function()
						return vim.fn.getcwd()
					end,
				},
			}
		end,
		keys = {
			{
				"<leader>dd",
				function()
					require("dap").run()
				end,
				desc = "Start/Restart Debugging",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Set Conditional Breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>ds",
				function()
					require("dap").disconnect()
				end,
				desc = "Stop Debugging",
			},
			{
				"<leader>de",
				function()
					local expr = vim.fn.input("Evaluate Expression: ")
					print(vim.inspect(require("dap").evaluate(expr)))
				end,
				desc = "Evaluate Expression in Debugger",
			},
			{
				"<leader>dw",
				function()
					require("dap").set_watch(vim.fn.input("Watch expression: "))
				end,
				desc = "Add/Remove Watch Expression",
			},
			{
				"<leader>dv",
				function()
					require("dap.ui.variables").hover()
				end,
				desc = "Show Debugging Variables",
			},
			{
				"<leader>dB",
				function()
					require("dap").step_back()
				end,
				desc = "Step Back",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause Debugging",
			},
			{
				"<leader>dlp",
				function()
					require("custom_dap_utils").pick_launch_profile() -- Open the launch profile picker
				end,
				desc = "Select Launch Profile from Multiple Projects",
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
