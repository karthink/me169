using Plots
using DifferentialEquations

f((p,r,s),params,t) = [ p*(r-s); r*(s-p); s*(p-r) ]

prob = ODEProblem(f, [1; 0.25; 2], (0.0, 100.0), nothing)
sol = solve(prob)
plot!(sol, vars=(1,2,3))
