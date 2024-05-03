{
  description = "My collection of flake templates";

  outputs = _: {
    templates = {
      rust = {
        path = ./rust;
        description = "A simple Rust template, without Naersk";
      };
    };
  };
}
