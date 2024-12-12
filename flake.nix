{
  description = "My collection of flake templates";

  outputs = _: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust template with complete flake";
      };

      rust-shell = {
        path = ./rust-shell;
        description = "Rust template with only a shell";
      };
    };
  };
}
