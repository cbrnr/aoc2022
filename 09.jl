using LinearAlgebra

include("utils.jl")

cookie = ""
input = get_aoc_input(9, cookie)

motions = split(strip(input), "\n")

function move(direction, head)
    if direction == "U"
        head[2] += 1
    elseif direction == "D"
        head[2] -= 1
    elseif direction == "R"
        head[1] += 1
    elseif direction == "L"
        head[1] -= 1
    end
    return head
end

function solve(n=2)
    knots = zeros(Int, n, 2)  # initial positions of all n knots
    head = @view knots[1, :]
    tail = @view knots[end, :]
    visited = [Tuple(tail)]
    for motion in motions
        direction, steps = split(motion)
        for _ in 1:parse(Int, steps)
            head = move(direction, head)
            for i in axes(knots, 1)[2:end]
                h = @view knots[i-1, :]
                t = @view knots[i, :]
                if norm(h - t) > sqrt(2)  # not touching
                    t .+= sign.(h .- t)  # move toward head
                end
            end
            push!(visited, Tuple(tail))
        end
    end
    return length(unique(visited))
end

# part 1
println("Number of visited positions: ", solve())

# part 2
println("Number of visited positions: ", solve(10))
