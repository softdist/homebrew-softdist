class SoftdistRelease < Formula
  desc "Software Distribution: Releases"
  homepage "https://github.com/softdist/docker.client"
  version "v0.3.4"
  license "MIT"

  # Main binary URL
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-run-darwin-amd64"
      sha256 "ac8955f74ef5fed08cd103cc0d8b6a8e8e7284defcbd0e7e2f0bd0066f0c5bcb"
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-run-darwin-arm64"
      sha256 "66e5232e8da25b694f18b05a5ed46343efc867ac34346565cc324cce3a21e200"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-run-linux-amd64"
      sha256 "30f432a6cf51e4438ffc0dcddc266f682f5afc78fa94b643f4b294379cd64028"
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-run-linux-arm64"
      sha256 "a6e423ed49aa8003a4eeddc279ead57caa85127a5ca0a43488628848f9a436d5"
    end
  end

  # sd-install resource
  resource "sd-install" do
    on_macos do
      if Hardware::CPU.intel?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-install-darwin-amd64"
        sha256 "a157250531eb4806f0b9f3b9324df8100f7ca8f45358271ea33a165205a652bc"
      elsif Hardware::CPU.arm?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-install-darwin-arm64"
        sha256 "74243fabb8d01a4d73e723ef372837e8f81f03309c9e67adaaee9d9d85d8f252"
      end
    end

    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-install-linux-amd64"
        sha256 "4edc9ffcda4a0e67a8c7f279ca9cc4953256bb660f1ce1e185fcb72f6bd105e2"
      elsif Hardware::CPU.arm?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-install-linux-arm64"
        sha256 "b15082354cc2426d0c62ff60c130e35a7a04f905097975346265410a2e30ee82"
      end
    end
  end

  # sd-extricate resource
  resource "sd-extricate" do
    on_macos do
      if Hardware::CPU.intel?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-extricate-darwin-amd64"
        sha256 "12c695514d304302261740ca0d7d6e2c9a238e5bd2085c880b83bbe42ffe69a6"
      elsif Hardware::CPU.arm?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-extricate-darwin-arm64"
        sha256 "17cc17df1d89f54e1830ebacb366611c4143390173826f49dd8395ca6080e298"
      end
    end

    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-extricate-linux-amd64"
        sha256 "7b87cf8ebffd23546d7289c0bc583846ebf3e9b76a3ecb4ac62368c44971dd71"
      elsif Hardware::CPU.arm?
        url "https://github.com/softdist/docker.client/releases/download/v0.3.4/sd-extricate-linux-arm64"
        sha256 "975c76fc07c84918e454cf66c36f4b90dd524787caaec32736f6e33ad3a76149"
      end
    end
  end

  # Correct install method with explicit handling
  def install
    # Detect the right filename and rename
    arch = if OS.mac? && Hardware::CPU.intel?
      "darwin-amd64"
    elsif OS.mac? && Hardware::CPU.arm?
      "darwin-arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      "linux-amd64"
    elsif OS.linux? && Hardware::CPU.arm?
      "linux-arm64"
    end

    bin.install "sd-run-#{arch}" => "sd-run"

    resource("sd-install").stage do
      bin.install "sd-install-#{arch}" => "sd-install"
    end

    resource("sd-extricate").stage do
      bin.install "sd-extricate-#{arch}" => "sd-extricate"
    end
  end

  # Tests
  test do
    system "#{bin}/sd-run", "--version"
    system "#{bin}/sd-install", "--version"
    system "#{bin}/sd-extricate", "--version"
  end
end
