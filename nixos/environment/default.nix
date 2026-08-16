{...}:

{
  # Tells apps to fallback to nvim for interfacing with text
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less -R";
  };
}
