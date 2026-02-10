{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    # All settings now go under this attribute
    settings = {
      user = {
        name = "Owlsly";
        email = "stefan.stanimirovic09@gmail.com";
      };

      # Your old extraConfig moves here directly
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
      pull = {
        rebase = true;
      };

      # Your old aliases move here
      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };
}
