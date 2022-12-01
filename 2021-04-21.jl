### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# ╔═╡ de89f8a4-df62-4784-a66a-5d423bd6c06f
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add("Plots")
	Pkg.add("PlutoUI")
	Pkg.add("DifferentialEquations")
	using Plots, PlutoUI, DifferentialEquations
end

# ╔═╡ f933cd96-b149-41fe-87ed-3908e77385ac
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))

# ╔═╡ 2e2bbe78-a2ee-11eb-3512-7bd5c9853d19
md"""
## Flows on a Circle

By flowing in one direction, the state can eventually return to its starting place - periodic motion in a 1D system!

### Example: Uniform oscillator
```math
\dot{\theta} = \Omega
```
"""

# ╔═╡ 0055620b-1244-49bb-bb0a-10eea6e0937e
md"""
### Is the state space a circle?

What is wrong with the system
```math
\dot{\theta} = \theta,\quad \theta \in \mathbb{R}
```
on a circle?

**Dynamics on a circle: $\dot{\theta} = f(\theta)$ needs to have a special property:**
"""

# ╔═╡ a3f8d70b-6f75-4c2d-9db7-a42feb4d2b3b
hint(md"""
	$\dot{\theta} = f(\theta),\quad f(\theta + 2 \pi) = f(\theta)$
	Otherwise $\dot{\theta}$ is not well-defined!
	""")

# ╔═╡ c7172d09-d670-4f81-a0fa-adb3f78f59a7
plot( identity, xlims = (0, 2*pi), 
	xlabel = "θ", ylabel = "f(θ)",
	label = "f(θ)")

# ╔═╡ f84da47c-ed4a-4784-b90a-c8f2f37a0cb9
md"""
## Fireflies
"""

# ╔═╡ 8a8a6ba3-f796-4d71-a785-84127ff30fe7
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/EnwVVE-EGVw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ 01891e39-5462-412b-a877-bf284c7f3194
begin
	Base.@kwdef mutable struct Firefly
		dt::Float64 = 0.002
		Ω::Float64 = 0.02
		ω::Float64 = 0.02
		A::Float64 = 0.0
		
		α::Float64 = pi/2
		θ::Float64 = 0.0
	end
	
	function step!(f::Firefly)
		f.α += f.dt * f.Ω
		f.θ += f.dt * (f.ω + f.A * sin(f.α - f.θ)) 
		
		f.α = f.α % 2*pi
		f.θ = f.θ % 2*pi
	end
	
	phases(f::Firefly) = [(cos(f.α),sin(f.α)), (cos(f.θ),sin(f.θ))]
	
	fp = Firefly()
	
	plt = plot(cos, sin, 0, 2*pi, aspect_ratio = 1.0, axis=false, ticks=false)
	scatter!(plt, phases(fp), color=[:red, :blue])
	
	@gif for i=1:1000
		step!(fp)
		plt = plot(cos, sin, 0, 2*pi, aspect_ratio = 1.0, axis=false, ticks=false)
		scatter!(plt, phases(fp), color=[:red, :blue])
	end
end

# ╔═╡ 0f1438ea-9c02-4272-9a5b-e80ae0486940


# ╔═╡ Cell order:
# ╟─de89f8a4-df62-4784-a66a-5d423bd6c06f
# ╟─f933cd96-b149-41fe-87ed-3908e77385ac
# ╟─2e2bbe78-a2ee-11eb-3512-7bd5c9853d19
# ╟─0055620b-1244-49bb-bb0a-10eea6e0937e
# ╠═a3f8d70b-6f75-4c2d-9db7-a42feb4d2b3b
# ╠═c7172d09-d670-4f81-a0fa-adb3f78f59a7
# ╟─f84da47c-ed4a-4784-b90a-c8f2f37a0cb9
# ╟─8a8a6ba3-f796-4d71-a785-84127ff30fe7
# ╠═01891e39-5462-412b-a877-bf284c7f3194
# ╠═0f1438ea-9c02-4272-9a5b-e80ae0486940
