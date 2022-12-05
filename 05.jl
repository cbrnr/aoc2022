using DataStructures

include("utils.jl")

cookie = ""
input = get_aoc_input(5, cookie)

function parse_stacks(s)
    s = split(s, "\n")  # split rows
    n_stacks = length(split(s[end]))
    stacks = [Stack{Char}() for n in 1:n_stacks]  # list of stacks
    for row in length(s)-1:-1:1
        items = s[row][2:4:end]
        for (i, item) in enumerate(items)
            item != ' ' && push!(stacks[i], item)
        end
    end
    return stacks
end

function move_stacks!(stacks, instruction; mode=:part1)
    n, from, to = parse.(Int, match(r".* (\d+) .* (\d+) .* (\d+)", instruction))
    items = [pop!(stacks[from]) for i in 1:n]
    mode == :part2 && reverse!(items)
    for item in items
        push!(stacks[to], item)
    end
end

# part 1
stacks, instructions = split(rstrip(input), "\n\n")
stacks = parse_stacks(stacks)
instructions = split(instructions, "\n")

for instruction in instructions
    move_stacks!(stacks, instruction)
end

println(String([first(stack) for stack in stacks]))

# part 2
stacks, instructions = split(rstrip(input), "\n\n")
stacks = parse_stacks(stacks)
instructions = split(instructions, "\n")

for instruction in instructions
    move_stacks!(stacks, instruction, mode=:part2)
end

println(String([first(stack) for stack in stacks]))
