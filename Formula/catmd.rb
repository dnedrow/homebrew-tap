class Catmd < Formula
  desc "cat for Markdown: render Markdown as styled text in the terminal"
  homepage "https://github.com/dnedrow/catmd"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.5/catmd-aarch64-apple-darwin.tar.xz"
      sha256 "baa57a31eed688122dff038a138e316c3636f040deb1ed59de498faf55bdf32c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.5/catmd-x86_64-apple-darwin.tar.xz"
      sha256 "029f01d19d246f031999c0cea8bc68272742a414c33f9afee9858814c9a9fa02"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.5/catmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a5e60d71b5da61bbb0da33f18e1e88f8e62895c96f551bdc254445cfe777a1f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.5/catmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a242eb44e69c92130b2f3964acaed3ca19d9db8f554ba1cc922a40f2a2813ff1"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "catmd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "catmd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "catmd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "catmd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
