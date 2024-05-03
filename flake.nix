{
  description = "My collection of flake templates";

  outputs.templates = {
    rust = {
      path = ./rust;
      description = "A simple Rust template, without Naersk";
    };
  };
}
