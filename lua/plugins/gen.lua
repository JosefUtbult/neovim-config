return {
  {
    "David-Kunz/gen.nvim",
    enabled = true,
    opts = {
      model = "llama3",
      -- model = "codegemma",
      quit_map = "q",
      retry_map = "<c-r>",
      accept_map = "<c-cr>",
      host = "localhost",
      port = "11434",
      display_mode = "split",
      show_prompt = false,
      show_model = false,
      no_auto_close = false,
      hidden = false,
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      command = function(options)
        local body = {model = options.model, stream = true}
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
      debug = false,
    }
  },
}
