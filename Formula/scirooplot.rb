class Scirooplot < Formula
  desc "Scientific plotting framework based on ROOT"
  license "GPL-3.0-or-later"
  version "3.1.0"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "ed6e9d6212bbe67fcc1c1300c9ff88c5e01ed7063a2dea797b3430cece15be95"

  depends_on "cmake"
  depends_on "python"
  depends_on "pybind11"
  depends_on "fmt"
  depends_on "boost"
  depends_on "root"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
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
