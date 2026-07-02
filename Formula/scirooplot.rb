class Scirooplot < Formula
  desc "Scientific plotting framework based on ROOT"
  license "GPL-3.0-or-later"
  version "2.0.0"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "8c94fe90de56c780c7404b7b036aed102dd7cbc350553552989f82ee62033b79"

  depends_on "cmake"
  depends_on "python"
  depends_on "fmt"
  depends_on "boost"
  depends_on "root" => :optional

  def install
    root_prefix = nil

    if build.with?("root")
      root_prefix = Formula["root"].opt_prefix
    elsif (rc = which("root-config"))
      root_prefix = Utils.popen_read(rc, "--prefix").chomp
    end

    system "echo", ENV["PATH"]
  
    if root_prefix.nil?
      odie <<~EOS
        ROOT is required to build SciRooPlot but was not found.

        You can install it via:
          brew install root

        or ensure root-config is available in homebrew PATH before retrying:
          source /path/to/root/bin/thisroot.sh
          ln -s $(root-config --bindir)/root-config $(brew --prefix)/bin/root-config

      EOS
    end

    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=#{root_prefix}"

    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           *args

    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
        Put the following line in your .zshrc to activate SciRooPlot:
          source $(brew --prefix scirooplot)/share/scirooplot/scirooplot-env.sh
    EOS
  end
end
