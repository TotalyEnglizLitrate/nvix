{config, ...}: {
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "night";
      transparent = config.nvix.transparent;
      styles = {
        floats =
          if config.nvix.transparent
          then "transparent"
          else "dark";
        sidebars =
          if config.nvix.transparent
          then "transparent"
          else "dark";
        comments.italic = true;
        functions.italic = false;
        variables.italic = false;
        keywords = {
          italic = false;
          bold = true;
        };
      };
    };
  };
}
