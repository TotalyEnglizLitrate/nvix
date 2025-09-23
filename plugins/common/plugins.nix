{
  pkgs,
  config,
  ...
}: let
  inherit (config.nvix.mkKey) mkKeymap;
in {
  extraPlugins = with pkgs.vimPlugins; [
    stay-centered-nvim
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-bullets";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-orgmode";
        repo = "org-bullets.nvim";
        rev = "21437cfa99c70f2c18977bffd423f912a7b832ea";
        hash = "sha256-/l8IfvVSPK7pt3Or39+uenryTM5aBvyJZX5trKNh0X0=";
      };
    })
  ];
  plugins = {
    comment = {
      enable = true;
      settings = {
        toggler.line = "<leader>/";
        opleader.line = "<leader>/";
      };
    };

    flash = {
      enable = true;
      settings = {
        modes.char.enabled = false;
      };
    };

    orgmode = {
      enable = true;
      settings = {
        org_agenda_files = "~/org/agenda/*";
        org_default_notes_file = "~/org/refile.org";
      };
    };

    cord.enable = true;
    lz-n.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    smart-splits.enable = true;
    trim.enable = true;
    visual-multi.enable = true;
    web-devicons.enable = true;
    which-key = {
      enable = true;
      settings.spec = config.wKeyList;
      settings.preset = "helix";
    };
  };
  opts = {
    timeout = true;
    timeoutlen = 250;
  };
  keymaps = [
    (mkKeymap "n" "<leader>vt" "<cmd>:lua require('flash').treesitter()<cr>" "Select Treesitter Node")
  ];
}
