include("utils.jl")

cookie = "53616c7465645f5f7a32a718d3b163f956adfbad422ecf93284bd7c6980cda968086b4d782a982b6f63c677b59e2e3f3b5281593a8440c84b1f4532df093de10"
# input = get_aoc_input(12, cookie)
input = """Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""

heightmap = permutedims(hcat(collect.(split(strip(input)))...))
origin = findfirst(x->x == 'S', heightmap)
destination = findfirst(x->x == 'E', heightmap)

current = origin
