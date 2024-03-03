local omnisharp_roslyn_cmd = "OmniSharp"

if vim.fn.executable(omnisharp_roslyn_cmd) ~= 1 then
  return
end


local root_files = { "*.sln", "*.csproj", "omnisharp.json", "function.json" }

vim.lsp.start {
  name = "omnisharp",
  cmd = { omnisharp_roslyn_cmd, '-z', '--hostPID', tostring(vim.fn.getpid()), '--languageserver' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {}
}
