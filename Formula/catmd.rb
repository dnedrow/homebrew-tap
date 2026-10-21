class Catmd < Formula
  desc "cat for Markdown: render Markdown as styled text in the terminal"
  homepage "https://github.com/dnedrow/catmd"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.9/catmd-aarch64-apple-darwin.tar.xz"
      sha256 "1fbc969f3be50914b3d631e877d6f22c2a26cf955da80321aab91962283a1d15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.9/catmd-x86_64-apple-darwin.tar.xz"
      sha256 "3238274469941b1d2fa33a5d8a3b9f421d0b3324fef8d1b2eec5278d45a0959a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.9/catmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "46795391f052a90ec30756b2cd80a1466d579a6819c8a77fbf18576888eb0bef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.9/catmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0eedabadabd5c81700d0a73a9d7134f695b7d2815f75a39471dbf6b7467a60bf"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def 
man1.install "catmd.1" if File.exist?("catmd.1")

    install_binary_aliases!
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

    
man1.install "catmd.1" if File.exist?("catmd.1")

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = 
Dir["*"] - doc_files - ["catmd.1"]

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
