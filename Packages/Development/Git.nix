{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "GbnGnlez";
        email = "GibranN.GonzalezS@outlook.com";
      };

      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };
    };
  };
}
