include("utils.jl")

cookie = ""
input = get_aoc_input(4, cookie)

sections = split.(split(input), ",")

function overlap(x; mode=:full)
    r1, r2 = [range(parse.(Int, split(elf, "-"))...) for elf in x]
    mode == :full && return r1 ⊆ r2 || r2 ⊆ r1
    mode == :partial && return !isdisjoint(r1, r2)
end

# part 1
println("Sum: ", sum(overlap.(sections)))

# part 2
println("Sum: ", sum(overlap.(sections, mode=:partial)))
