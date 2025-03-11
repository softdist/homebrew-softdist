class SoftdistRelease < Formula
  desc "Software Distribution: Releases"
  homepage "https://github.com/softdist/docker.client"
  version "main"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-darwin-amd64"
      sha256 "cc102989665bc7aec81e3319a65375782b7e46262968ffb92b7a47bc10761b63"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-darwin-amd64"
        sha256 "62c40b960b9fed52bf391d0dd91496ac9a7ee80311eb01370712b2574b03bd89"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-darwin-amd64"
        sha256 "8a0427ac0d29cd4bbe816c56b7c4c76a13a641b33aa4406e7f63c346a014ce87"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-darwin-arm64"
      sha256 "d6ebdef1d01d6b75ea28c7a8a711f3bbb26384dc16812f3fe3aafa2fc83e0c08"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-darwin-arm64"
        sha256 "736d26032ee788eead96be3ebb4eee61694fbb3e6476abca0e896b4d058f9d9e"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-darwin-arm64"
        sha256 "362e123bf6035ce5279ba4e1a6b5fc5ec01a1af06d3c9cb7b2970c3bb2899cfe"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-linux-amd64"
      sha256 "b98c9f21a55af87335d1ab59679dcaab0d8f3b09769a35c3a7f8c3a7cbce5b1f"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-linux-amd64"
        sha256 "70c767689c5623316ccdc65792c42a20bc10320860b7450e6d9ed55ac06e1905"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-linux-amd64"
        sha256 "cb7ec36dafe0a2290bc262f73e0ca2e25036338c3b2922b000875aa75a276fdd"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/softdist/docker.client/releases/download/main/sd-run-linux-arm64"
      sha256 "d599c462a4875799d4f28b91380692b5ad66130ff8cd7af6d403d3d0e35618ad"

      resource "sd-install" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-install-linux-arm64"
        sha256 "c107fdd5b629832a99aa845ff692dd6bda033c60cc86e6bd3c5c2f6d57fecf2c"
      end

      resource "sd-extricate" do
        url "https://github.com/softdist/docker.client/releases/download/main/sd-extricate-linux-arm64"
        sha256 "cf7c99e3a80ad167b7a5f30e375a7d3d74e19142058fa28669f7bd1f553aa78c"
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