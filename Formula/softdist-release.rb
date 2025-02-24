class SoftdistRelease < Formula
  desc "Docker client emulator"
  homepage "https://github.com/softdist/docker.client"
  version "0.1.8"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/softdist/docker.client/releases/download/v0.1.8/docker.client-darwin-arm64"
    sha256 "<SHA256_MAC_ARM64>"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/softdist/docker.client/releases/download/v0.1.8/docker.client-darwin-amd64"
    sha256 "<SHA256_MAC_AMD64>"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/softdist/docker.client/releases/download/v0.1.8/docker.client-linux-arm64"
    sha256 "<SHA256_LINUX_ARM64>"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/softdist/docker.client/releases/download/v0.1.8/docker.client-linux-amd64"
    sha256 "<SHA256_LINUX_AMD64>"
  else
    odie "Unsupported architecture"
  end

  def install
    bin.install "docker.client"
  end

  def post_install
    if OS.mac?
      system "codesign", "--force", "--deep", "--sign", "-", "#{bin}/docker.client"
    end
  end

  test do
    system "#{bin}/docker.client", "--version"
  end
end
