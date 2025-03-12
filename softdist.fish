function .softdist.make -d "Make SoftDist Release" -a version
  # arm64 windows not supported currently

set -l branch "v0.3.4"  

# Run

set -l run_darwin_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-run-darwin-amd64"
set -l run_darwin_amd64_checksum (curl -fsSL $run_darwin_amd64_url | sha256 )

set -l run_darwin_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-run-darwin-arm64"
set -l run_darwin_arm64_checksum (curl -fsSL $run_darwin_arm64_url | sha256 )

set -l run_linux_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-run-linux-amd64"
set -l run_linux_amd64_checksum (curl -fsSL $run_linux_amd64_url | sha256 )

set -l run_linux_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-run-linux-arm64"
set -l run_linux_arm64_checksum (curl -fsSL $run_linux_arm64_url | sha256 )


# Install

set -l install_darwin_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-install-darwin-amd64"
set -l install_darwin_amd64_checksum (curl -fsSL $install_darwin_amd64_url | sha256 )

set -l install_darwin_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-install-darwin-arm64"
set -l install_darwin_arm64_checksum (curl -fsSL $install_darwin_arm64_url | sha256 )

set -l install_linux_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-install-linux-amd64"
set -l install_linux_amd64_checksum (curl -fsSL $install_linux_amd64_url | sha256 )

set -l install_linux_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-install-linux-arm64"
set -l install_linux_arm64_checksum (curl -fsSL $install_linux_arm64_url | sha256 )

# Extricate

set -l extricate_darwin_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-extricate-darwin-amd64"
set -l extricate_darwin_amd64_checksum (curl -fsSL $extricate_darwin_amd64_url | sha256 )

set -l extricate_darwin_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-extricate-darwin-arm64"
set -l extricate_darwin_arm64_checksum (curl -fsSL $extricate_darwin_arm64_url | sha256 )

set -l extricate_linux_amd64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-extricate-linux-amd64"
set -l extricate_linux_amd64_checksum (curl -fsSL $extricate_linux_amd64_url | sha256 )

set -l extricate_linux_arm64_url "https://github.com/softdist/docker.client/releases/download/$branch/sd-extricate-linux-arm64"
set -l extricate_linux_arm64_checksum (curl -fsSL $extricate_linux_arm64_url | sha256 )


# Code

set -l ruby "\
class SoftdistRelease < Formula
  desc \"Software Distribution: Releases\"
  homepage \"https://github.com/softdist/docker.client\"
  version \"$branch\"
  license \"MIT\"

  # Main binary URL
  on_macos do
    if Hardware::CPU.intel?
      url \"$run_darwin_amd64_url\"
      sha256 \"$run_darwin_amd64_checksum\"
    elsif Hardware::CPU.arm?
      url \"$run_darwin_arm64_url\"
      sha256 \"$run_darwin_arm64_checksum\"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url \"$run_linux_amd64_url\"
      sha256 \"$run_linux_amd64_checksum\"
    elsif Hardware::CPU.arm?
      url \"$run_linux_arm64_url\"
      sha256 \"$run_linux_arm64_checksum\"
    end
  end

  # sd-install resource
  resource \"sd-install\" do
    on_macos do
      if Hardware::CPU.intel?
        url \"$install_darwin_amd64_url\"
        sha256 \"$install_darwin_amd64_checksum\"
      elsif Hardware::CPU.arm?
        url \"$install_darwin_arm64_url\"
        sha256 \"$install_darwin_arm64_checksum\"
      end
    end

    on_linux do
      if Hardware::CPU.intel?
        url \"$install_linux_amd64_url\"
        sha256 \"$install_linux_amd64_checksum\"
      elsif Hardware::CPU.arm?
        url \"$install_linux_arm64_url\"
        sha256 \"$install_linux_arm64_checksum\"
      end
    end
  end

  # sd-extricate resource
  resource \"sd-extricate\" do
    on_macos do
      if Hardware::CPU.intel?
        url \"$extricate_darwin_amd64_url\"
        sha256 \"$extricate_darwin_amd64_checksum\"
      elsif Hardware::CPU.arm?
        url \"$extricate_darwin_arm64_url\"
        sha256 \"$extricate_darwin_arm64_checksum\"
      end
    end

    on_linux do
      if Hardware::CPU.intel?
        url \"$extricate_linux_amd64_url\"
        sha256 \"$extricate_linux_amd64_checksum\"
      elsif Hardware::CPU.arm?
        url \"$extricate_linux_arm64_url\"
        sha256 \"$extricate_linux_arm64_checksum\"
      end
    end
  end

  # Correct install method with explicit handling
  def install
    # Detect the right filename and rename
    arch = if OS.mac? && Hardware::CPU.intel?
      \"darwin-amd64\"
    elsif OS.mac? && Hardware::CPU.arm?
      \"darwin-arm64\"
    elsif OS.linux? && Hardware::CPU.intel?
      \"linux-amd64\"
    elsif OS.linux? && Hardware::CPU.arm?
      \"linux-arm64\"
    end

    bin.install \"sd-run-#{arch}\" => \"sd-run\"

    resource(\"sd-install\").stage do
      bin.install \"sd-install-#{arch}\" => \"sd-install\"
    end

    resource(\"sd-extricate\").stage do
      bin.install \"sd-extricate-#{arch}\" => \"sd-extricate\"
    end
  end

  # Tests
  test do
    system \"#{bin}/sd-run\", \"--version\"
    system \"#{bin}/sd-install\", \"--version\"
    system \"#{bin}/sd-extricate\", \"--version\"
  end
end"

echo "$ruby" > ./Formula/softdist-release.rb
echo ""
end
