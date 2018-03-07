function cubedecompose(lib::PolyhedraLibrary)
    p = polyhedron(convexhull([ 1.,  1,   1],
                              [ 1., -1,   1],
                              [ 1.,  1,  -1],
                              [ 1., -1,  -1],
                              [-1.,  1,  1],
                              [-1., -1,  1],
                              [-1.,  1, -1],
                              [-1., -1, -1]))
    # FIXME failing
    #p = polyhedron(convexhull(SymPoint([1., 1, 1]),
    #                          SymPoint([1., -1, 1]),
    #                          SymPoint([1., 1, -1]),
    #                          SymPoint([1., -1, -1])))
    points = GeometryTypes.decompose(GeometryTypes.Point{3, Float32}, p)
    faces = GeometryTypes.decompose(GeometryTypes.Face{3, Int}, p)
    normals = GeometryTypes.decompose(GeometryTypes.Normal{3,Float64}, p)
    @test length(points) == 36
    @test length(faces) == 12
    @test length(normals) == 36
#    Dict([0, 0, -1] => [[[-1.0, -1.0, -1.0], [1.0, -1.0, -1.0], [1.0, 1.0, -1.0]],
#                        [[1.0, 1.0, -1.0], [-1.0, 1.0, -1.0], [-1.0, -1.0, -1.0]]
end
function largedecompose(lib::PolyhedraLibrary)
    isa(lib, SimplePolyhedraLibrary) && return
    contains(string(typeof(lib)),"LRSLibrary") && return
    V = [-1 -1  1;
         -1  1  1;
          1 -1  1;
          1  1  1;
          0  1 -1;
          1  0 -1;
         -1  0 -1;
          0 -1 -1]
    R = [0 0 1]
    v = vrep(V, R)
    p = polyhedron(v, lib)
    @test GeometryTypes.decompose(GeometryTypes.Point{3, Float32}, p) ==
    [GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0)]

     # TODO: restore this test so that it tries to decompose into a Face with
     # a non-zero offset, once https://github.com/JuliaGeometry/GeometryTypes.jl/issues/89 is resolved
    @test GeometryTypes.decompose(GeometryTypes.Face{3, Int}, p) ==
    [GeometryTypes.Face{3, Int}(2,3,4) .- 1,
     GeometryTypes.Face{3, Int}(5,6,7) .- 1,
     GeometryTypes.Face{3, Int}(8,9,10) .- 1,
     GeometryTypes.Face{3, Int}(11,12,13) .- 1,
     GeometryTypes.Face{3, Int}(14,15,16) .- 1,
     GeometryTypes.Face{3, Int}(17,18,19) .- 1,
     GeometryTypes.Face{3, Int}(20,21,22) .- 1,
     GeometryTypes.Face{3, Int}(23,24,25) .- 1,
     GeometryTypes.Face{3, Int}(26,27,28) .- 1,
     GeometryTypes.Face{3, Int}(29,30,31) .- 1,
     GeometryTypes.Face{3, Int}(32,33,34) .- 1,
     GeometryTypes.Face{3, Int}(35,36,37) .- 1,
     GeometryTypes.Face{3, Int}(38,39,40) .- 1,
     GeometryTypes.Face{3, Int}(41,42,43) .- 1,
     GeometryTypes.Face{3, Int}(44,45,46) .- 1,
     GeometryTypes.Face{3, Int}(47,48,49) .- 1,
     GeometryTypes.Face{3, Int}(50,51,52) .- 1,
     GeometryTypes.Face{3, Int}(53,54,55) .- 1]
    @test GeometryTypes.decompose(GeometryTypes.Normal{3,Float64}, p) ==
    [GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0)]
end

function decompose(lib::PolyhedraLibrary)
    cubedecompose(lib)
    largedecompose(lib)
end
