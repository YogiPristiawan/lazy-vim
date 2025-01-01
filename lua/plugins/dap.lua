return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    tag = "0.9.0",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        enabled = true,
        config = function(plugins)
          local dap = require("dap")
          --
          local default_config = {
            delve = {
              path = "dlv",
              initialize_timeout_sec = 20,
              port = "${port}",
              args = {},
              build_flags = "",
              detached = true,
            },
          }

          local args = { "dap", "-l", "127.0.0.1:" .. default_config.delve.port }
          vim.list_extend(args, default_config.delve.args)

          -- setup adapter
          dap.adapters.go = {
            type = "server",
            port = default_config.delve.port,
            executable = {
              command = default_config.delve.path,
              args = args,
              detached = default_config.delve.detached,
            },
            options = {
              initialize_timeout_sec = default_config.delve.initialize_timeout_sec,
            },
          }

          dap.adapters.custom = {
            type = "server",
            host = "127.0.0.1",
            port = 2345,
          }
          --
          dap.configurations.go = {
            {
              type = "go",
              name = "Dap-Go: Debug",
              request = "launch",
              program = "${file}",
              buildFlags = default_config.delve.build_flags,
            },
            {
              name = "Dap-Go: Debug (Arguments)",
              type = "go",
              request = "launch",
              program = "${file}",
              args = plugins.get_arguments,
              buildFlags = default_config.delve.build_flags,
            },
            {
              type = "go",
              name = "Dap-Go: Debug Package",
              request = "launch",
              program = "${fileDirname}",
              buildFlags = default_config.delve.build_flags,
            },
            {
              type = "go",
              name = "Dap-Go: Attach",
              mode = "local",
              request = "attach",
              processId = plugins.filtered_pick_process,
              buildFlags = default_config.delve.build_flags,
            },
            {
              type = "go",
              name = "Dap-Go: Debug test file",
              request = "launch",
              mode = "test",
              -- program = "${file}",
              program = "${fileDirname}",
              buildFlags = default_config.delve.build_flags,
              dlvCwd = vim.fn.getcwd() .. "/cmd",
            },
            {
              type = "custom",
              name = "Custom: Connect headless dlv 127.0.0.1:2345",
              request = "attach",
              mode = "remote",
            },
          }
        end,
      },
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        tag = "v1.96.0",
        dependencies = {
          "mxsdev/nvim-dap-vscode-js",
          config = function()
            require("dap-vscode-js").setup({
              -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
              debugger_path = "/home/yuu/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
              -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
              adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
              -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
              -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
              log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
            })

            local dap = require("dap")

            for _, language in ipairs({ "typescript", "javascript" }) do
              dap.configurations[language] = {
                -- pnpm
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "pnpm dev",
                  -- program = "${workspaceFolder}/app/bin/www",
                  cwd = "${workspaceFolder}",
                  runtimeExecutable = "pnpm",
                  runtimeArgs = { "run", "dev" },
                  console = "integratedTerminal",
                },

                -- yarn
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "yarn dev",
                  -- program = "${workspaceFolder}/app/bin/www",
                  cwd = "${workspaceFolder}",
                  runtimeExecutable = "yarn",
                  runtimeArgs = { "run", "dev" },
                  console = "integratedTerminal",
                },

                -- npm
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "npm start",
                  program = "${workspaceFolder}/app/bin/www",
                  cwd = "${workspaceFolder}",
                  runtimeExecutable = "npm",
                  runtimeArgs = { "run", "start" },
                  console = "integratedTerminal",
                  env = {
                    NODE_ENV = "development",
                  },
                },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "npm dev",
                  cwd = "${workspaceFolder}",
                  runtimeExecutable = "npm",
                  runtimeArgs = { "run", "dev" },
                  console = "integratedTerminal",
                  env = {
                    NODE_ENV = "development",
                  },
                },
                -- {
                --   type = "pwa-node",
                --   request = "launch",
                --   name = "vitest run ${relativeFile}",
                --   cwd = "${workspaceFolder}",
                --   runtimeExecutable = "npm",
                --   runtimeArgs = { "run", "test" },
                --   program = "${workspaceRoot}/node_modules/vitest/vitest.mjs",
                --   args = { "run", "${relativeFile}" },
                --   console = "integratedTerminal",
                --   env = {
                --     NODE_ENV = "test",
                --   },
                -- },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "vitest run ${relativeFile}",
                  cwd = "${workspaceFolder}",
                  runtimeExecutable = "vitest",
                  runtimeArgs = { "run", "${relativeFile}" },
                  console = "integratedTerminal",
                  -- env = {
                  --   NODE_ENV = "test",
                  -- },
                },

                -- others
                {
                  type = "pwa-node",
                  request = "attach",
                  name = "Attach 2",
                  processId = require("dap.utils").pick_process,
                  cwd = "${workspaceFolder}",
                },
              }
            end
          end,
        },
      },
      {
        "xdebug/vscode-php-debug",
        build = "npm install --legacy-peer-deps && npm run build",
        config = function()
          local dap = require("dap")

          dap.adapters.php = {
            type = "executable",
            command = "node",
            args = { os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-php-debug/out/phpDebug.js" },
          }

          dap.configurations.php = {
            {
              name = "Listen for Xdebug",
              type = "php",
              request = "launch",
              port = 9003,
            },
            {
              name = "Run current script",
              type = "php",
              request = "launch",
              port = 9003,
              cwd = "${fileDirname}",
              program = "${file}",
              runtimeExecutable = "php",
            },
          }
        end,
      },
    },
  },
}
