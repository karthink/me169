using LinearAlgebra
using DifferentialEquations
using Plots
pyplot()

# RC circuit
#-----------
V, R, C = 10, 1e3, 1e-3
function rc_problem(starting_ratio)
    frc(q,p,t) = V/R - q/(R*C)
    q0 = starting_ratio*C*V
    tspan = (0, 3/(R*C))

    rcprob = ODEProblem(frc, q0, tspan)
    rcsol = solve(rcprob)
    return rcsol
end

rcplot = plot!(rc_problem(0.5),
              title = "RC circuit dynamics",
              linewidth = 2,
              ylims = (0, 2*C*V), reuse = false)

# Logistic equation
#------------------
r, K = 0.1, 1000
function logistic_problem(starting_ratio)
    flog(N, p, t) = r * N * (1 - N/K)
    N0 = starting_ratio*K
    tspanlog = (0, 12/r)

    logprob = ODEProblem(flog, N0, tspanlog)
    logsol = solve(logprob)
    return logsol
end

logplot = plot!(logistic_problem(0.01),
               title = "Logistic equation dynamics",
               linewidth = 2,
                ylims = (0, 2*K), reuse = false)

