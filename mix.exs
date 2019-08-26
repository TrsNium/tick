defmodule Tick.MixProject do
  use Mix.Project

  def project do
    [
      app: :tick,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {Tick.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_state_machine, "~> 2.0"},
      {:cowboy, "~>1.0.4"},
      {:plug, "~>1.1.0"}
    ]
  end
end
