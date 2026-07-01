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

  def install
    opoo <<~EOS
      SciRooPlot requires ROOT.

      If needed install via Homebrew:
        brew install root

      Or ensure an existing ROOT installation is active:
        source /path/to/root/bin/thisroot.sh
    EOS

    root_prefix = nil
    if which("root-config")
      root_prefix = Utils.popen_read("root-config", "--prefix").chomp
    elsif ENV["ROOTSYS"]
      root_prefix = ENV["ROOTSYS"]
    end
    ENV.append_path "CMAKE_PREFIX_PATH", root_prefix if root_prefix

    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_PREFIX_PATH=#{ENV["CMAKE_PREFIX_PATH"]}",
           *std_cmake_args

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
