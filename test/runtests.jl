using Polyhedra
using Base.Test

import MultivariatePolynomials
MP = MultivariatePolynomials

using StaticArrays

include("utils.jl")
include("config.jl")
include("alltests.jl")

include("libraries.jl")

include("elements.jl")
include("comp.jl")
include("representation.jl")
include("polyhedron.jl")

include("redundancy.jl")
include("doubledescription.jl")

include("interval.jl")

include("polyhedra_to_lpqp.jl")
include("default.jl")

include("show.jl")

for lib in libraries
    basicpolyhedrontests(lib)
end

for (testname, testfun) in alltests
    @testset "$testname tests" begin
        for arith in [("floating point", float_libraries), ("exact", exact_libraries)]
            arithname, arith_libraries = arith
            @testset "$testname tests in $arithname arithmetic with $(typeof(library))" for library in arith_libraries
                testfun(library)
            end
            length(arith_libraries) == 0 && warn("$testname tests in $arithname arithmetics test not run!")
        end
    end
end
