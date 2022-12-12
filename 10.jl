include("utils.jl")

cookie = ""
input = get_aoc_input(10, cookie)

program = split(strip(input), "\n")

function run_program(program)
    program = deepcopy(program)
    cycle = 1
    value = 1
    stack = []
    x = []
    while !isempty(program) || !isempty(stack)
        push!(x, value)
        if !isempty(program)
            instruction = popfirst!(program)
            push!(stack, [instruction, instruction == "noop" ? 1 : 2])
        end
        if stack[1][2] == 1  # run instruction now
            if startswith(stack[1][1], "addx")
                _, n = split(stack[1][1])
                value += parse(Int, n)
            end
            popfirst!(stack)
        else
            stack[1][2] -= 1
        end
        cycle += 1
    end
    return x
end

x = run_program(program)

# part 1
println("Sum of signal strengths: ", sum(x[20:40:end] .* (20:40:length(x))))

# part 2
function draw_image(x)
    image = fill(' ', 6, 40)
    for cycle in eachindex(x)
        if mod1(cycle, 40) in x[cycle]:x[cycle] + 2
            image[(cycle - 1) ÷ 40 + 1, mod1(cycle, 40)] = '#'
        end
    end
    return image
end

image = draw_image(x)
for row in eachrow(image)
    println(join(row))
end
