include("utils.jl")

cookie = ""
input = get_aoc_input(6, cookie)

s = strip(input)

function find_start(s, n_distinct=4)
    i = n_distinct
    while length(unique(s[i-n_distinct+1:i])) != n_distinct
        i += 1
    end
    return i
end

# part 1
println("Start of packet: ", find_start(s))

# part 2
println("Start of message: ", find_start(s, 14))
