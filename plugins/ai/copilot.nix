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
    (mkKeymap ["n" "v"] "<leader>ae" "<cmd>CopilotChatEditWithInstruction<CR>" "Edit with instruction")
    (mkKeymap ["n" "v"] "<leader>ag" "<cmd>CopilotChatRun grammar_correction<CR>" "Grammar Correction")
    (mkKeymap ["n" "v"] "<leader>at" "<cmd>CopilotChatRun translate<CR>" "Translate")
    (mkKeymap ["n" "v"] "<leader>ak" "<cmd>CopilotChatRun keywords<CR>" "Keywords")
    (mkKeymap ["n" "v"] "<leader>ad" "<cmd>CopilotChatRun docstring<CR>" "Docstring")
    (mkKeymap ["n" "v"] "<leader>aa" "<cmd>CopilotChatRun add_tests<CR>" "Add Tests")
    (mkKeymap ["n" "v"] "<leader>ao" "<cmd>CopilotChatRun optimize_code<CR>" "Optimize Code")
    (mkKeymap ["n" "v"] "<leader>af" "<cmd>CopilotChatRun fix_bugs<CR>" "Fix Bugs")
    (mkKeymap ["n" "v"] "<leader>ax" "<cmd>CopilotChatRun explain_code<CR>" "Explain Code")
    (mkKeymap ["n" "v"] "<leader>al" "<cmd>CopilotChatRun code_readability_analysis<CR>" "Code Readability Analysis")
  ];
}
