class Sd < Formula
  desc "SD Tools: sd-run, sd-install, sd-extricate"
  homepage "https://github.com/softdist/docker.client"
  version "main"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-darwin-amd64"
      sha256 "SHA256_FOR_SD_RUN_DARWIN_AMD64"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-darwin-amd64"
        sha256 "SHA256_FOR_SD_INSTALL_DARWIN_AMD64"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-darwin-amd64"
        sha256 "SHA256_FOR_SD_EXTRICATE_DARWIN_AMD64"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-darwin-arm64"
      sha256 "SHA256_FOR_SD_RUN_DARWIN_ARM64"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-darwin-arm64"
        sha256 "SHA256_FOR_SD_INSTALL_DARWIN_ARM64"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-darwin-arm64"
        sha256 "SHA256_FOR_SD_EXTRICATE_DARWIN_ARM64"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-linux-amd64"
      sha256 "SHA256_FOR_SD_RUN_LINUX_AMD64"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-linux-amd64"
        sha256 "SHA256_FOR_SD_INSTALL_LINUX_AMD64"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-linux-amd64"
        sha256 "SHA256_FOR_SD_EXTRICATE_LINUX_AMD64"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-linux-arm64"
      sha256 "SHA256_FOR_SD_RUN_LINUX_ARM64"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-linux-arm64"
        sha256 "SHA256_FOR_SD_INSTALL_LINUX_ARM64"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-linux-arm64"
        sha256 "SHA256_FOR_SD_EXTRICATE_LINUX_ARM64"
      end
    end
  end

  def install
    bin.install "sd-run"
    bin.install resource("sd-install")
    bin.install resource("sd-extricate")
  end

  test do
    system "#{bin}/sd-run", "--version"
    system "#{bin}/sd-install", "--version"
    system "#{bin}/sd-extricate", "--version"
  end
end