include("basic.jl")
include("simplex.jl")
include("permutahedron.jl")
include("board.jl")
include("docexample.jl")
include("decompose.jl")
include("issue48.jl")
include("empty.jl")

const misctests = Dict("basic" => basictest,
                       "doc" => doctest,
                       "simplex" => simplextest,
                       "permutahedron" => permutahedrontest,
                       "board" => boardtest,
                       "decompose" => decompose,
                       "issue48" => issue48test,
                       "empty" => emptytest)

@polytestset misc
