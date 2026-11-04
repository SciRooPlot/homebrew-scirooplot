class Scirooplot < Formula
  desc "ROOT-based C++ and Python framework to define, organize and generate plots"
  license "GPL-3.0-or-later"

  version "4.0.0"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "6c7165854f8720c12a915be74499ab4120077b5753b309e91b0de44deaa22f20"

  depends_on "cmake"
  depends_on "python"
  depends_on "pybind11" => :build
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

  test do
    system bin/"srp", "info"
  end

  def caveats
    <<~EOS
      To activate SciRooPlot (best place it in ~/.zshrc or ~/.bashrc):

        source $(brew --prefix scirooplot)/share/scirooplot/env.sh
    EOS
  end
end
