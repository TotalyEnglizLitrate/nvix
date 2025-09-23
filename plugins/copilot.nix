{
  lib,
  config,
  ...
}: let
  inherit (config.nvix.mkKey) mkKeymap wKeyObj;
  inherit (lib.nixvim) mkRaw;
in {
  plugins = {
    copilot-chat.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        filetypes.markdown = true;
        suggestion = {
          enabled = true;
          auto_trigger = true;
        };
      };
    };
  };
  wKeyList = [(wKeyObj ["<leader>a" "󰚩" "ai"])];
  keymaps = [
    (mkKeymap "n" "<leader>ac"
      (
        mkRaw # lua

        ''
          function()
            if vim.g.copilot_status == nil then
              vim.g.copilot_status = "running"
            end
            if vim.g.copilot_status == "running" then
              vim.g.copilot_status = "stopped"
              vim.cmd("Copilot disable")
            else
              vim.g.copilot_status = "running"
              vim.cmd("Copilot enable")
            end
          end
        ''
      ) "Toggle Copilot")

    (mkKeymap "n" "<leader>a" "<cmd>CopilotChat<CR>" "Copilot Chat")
    (mkKeymap ["n" "v"] "<leader>ad" "<cmd>CopilotChatDocs<CR>" "Docstring")
    (mkKeymap ["n" "v"] "<leader>at" "<cmd>CopilotChatTests<CR>" "Add Tests")
    (mkKeymap ["n" "v"] "<leader>ao" "<cmd>CopilotChatOptimize<CR>" "Optimize Code")
    (mkKeymap ["n" "v"] "<leader>af" "<cmd>CopilotChatFix<CR>" "Fix Bugs")
    (mkKeymap ["n" "v"] "<leader>ax" "<cmd>CopilotChatExplain<CR>" "Explain Code")
    (mkKeymap ["n" "v"] "<leader>al" "<cmd>CopilotChatReview<CR>" "Code Readability Analysis")
  ];
}
