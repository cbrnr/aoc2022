include("utils.jl")

cookie = ""
input = get_aoc_input(9, cookie)

motions = split(strip(input), "\n")

mutable struct Point
    x::Int
    y::Int
end

Base.:+(a::Point, b::Point) = Point(a.x + b.x, a.y + b.y)
Base.:-(a::Point, b::Point) = Point(a.x - b.x, a.y - b.y)
Base.isequal(a::Point, b::Point) = (a.x == b.x) && (a.y == b.y)
Base.hash(a::Point) = hash((a.x, a.y))
Base.abs(a::Point) = sqrt(a.x^2 + a.y^2)
Base.sign(a::Point) = Point(sign(a.x), sign(a.y))

function move(motions)
    head, tail = Point(0, 0), Point(0, 0)
    visited = [Point(0, 0)]
    for motion in motions
        direction, steps = split(motion)
        for _ in 1:parse(Int, steps)
            if direction == "U"
                head.y += 1
            elseif direction == "D"
                head.y -= 1
            elseif direction == "R"
                head.x += 1
            elseif direction == "L"
                head.x -= 1
            end
            if abs(head - tail) > sqrt(2)  # not touching
                tail += sign(head - tail)  # move toward head
            end
            push!(visited, deepcopy(tail))
        end
    end
    return visited
end

# part 1
println("Number of visited positions: ", length(unique(move(motions))))
