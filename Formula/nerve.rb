class Nerve < Formula
  desc "Per-worktree port/env isolation so AI agents can run your whole stack"
  homepage "https://github.com/mascah/nerve"
  url "https://github.com/mascah/nerve/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  head "https://github.com/mascah/nerve.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/mascah/nerve/internal/version.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/nerve"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nerve version")
  end
end
