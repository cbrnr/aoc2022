include("utils.jl")

cookie = ""
input = get_aoc_input(1, cookie)

elves = split.(split(input, "\n\n"))  # split into elves, then food items per elf

calories = sort!([sum(parse.(Int, elf)) for elf in elves], rev=true)

# part 1
println("Maximum calories: ", calories[1])

# part 2
println("Sum of top three calories: ", sum(calories[1:3]))
