local M = {}

function M.load(module)
  require("config." .. module)
end

M = {
  icons = {
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    dap = {
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = "󰈚 ",
      Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
    },
    diagnostics = {
      error = " ",
      warning = " ",
      info = " ",
      hint = "󰌶 ",
    },
  },
}

return M
