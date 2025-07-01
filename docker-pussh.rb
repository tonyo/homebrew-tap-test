class DockerPussh < Formula
  desc "Docker CLI plugin to push images to remote Docker daemons via SSH"
  homepage "https://github.com/psviderski/unregistry"
  url "https://github.com/tonyo/unregistry/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "da6c9398b5ddf24e156ca80a61fb07f09206d9f825200ed709099be62672620a"
  license "Apache-2.0"
  version "0.1.0"

  head "https://github.com/psviderski/unregistry.git", branch: "main"

  def install
    bin.install "docker-pussh"
    # The install section runs in a sandbox so we can't create a symlink in user's home directory.
    # Prompt to create a symlink in Docker CLI plugins directory in caveats.
  end

  def caveats
    <<~EOS
      To use docker-pussh as a Docker CLI plugin ('docker pussh' command) you need to create a symlink:

        mkdir -p ~/.docker/cli-plugins
        ln -sf #{opt_bin}/docker-pussh ~/.docker/cli-plugins/docker-pussh

      After installation, you can use it with:
        docker pussh [OPTIONS] IMAGE[:TAG] [USER@]HOST[:PORT]

      To uninstall the plugin:
        rm ~/.docker/cli-plugins/docker-pussh
    EOS
  end

  test do
    # Test the command output with no arguments.
    assert_match "IMAGE and HOST are required", shell_output("#{bin}/docker-pussh 2>&1", 1)
  end
end
