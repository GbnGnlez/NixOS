{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "GbnGnlez";
        email = "GbnGnlez@outlook.com";
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
