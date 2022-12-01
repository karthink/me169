using DifferentialEquations
using Plots
using LinearAlgebra

function lorenz((x,y,z)::Tuple{Float64,3}, (σ,r,b)::Tuple{Float64,3}, t::Float64)
    [ σ*(y-x); r*x - y - x*z; x*y - b*z ]
end

(σ, r, b) = (10., 28., 8.0/3)
prob = ODEProblem(lorenz, [0.;1.;0.], (0.0,1000.0), (σ, r, b))
sol=solve(prob, Tsit5())

plot(sol,vars=(1,2,3))

# Find number of neighbors in a sphere of radius ϵ around each point in the solution.

inside(p1::Vector{Float64}, p2::Vector{Float64}; distance=0.1) = norm(p1 - p2) < distance

numpoints = 18

mutable struct Dims
    ϵ::Vector{Float64}
    N::Vector{Float64}
end

dim = Dims([0. for _ in 1:numpoints], [0 for _ in 1:numpoints])
k = 1
L = length(sol.u)
for ϵ in 10 .^(range(-1.4,2.,length=numpoints))
    N = 0
    for n1 in 100:L, n2 in n1:L
            if inside(sol.u[n1],sol.u[n2], distance=ϵ)
                N += 1
            end
    end
    dim.ϵ[k] = ϵ
    dim.N[k] = float(N)/L
    k += 1
end

plot(dim.ϵ,dim.N,label=false, xscale=:log10,yscale=:log10, ms=4.0, markershape=:circle)
# plot(dim,label=false, xscale=:log10,yscale=:log10, ms=4.0, markershape=:circle)
plot!(t -> 10^(1.776937013698513 * log10(t) + 3.6183410999702157), xlims=(0.1,100))

[ log10.(dim.ϵ[8:15]) one.(8:15) ] \ log10.(dim.N[8:15])
