include("utils.jl")

cookie = ""
input = get_aoc_input(3, cookie)

"""
    find_duplicate(s)

Find duplicate item (character) in both compartments of a rucksack.
"""
function find_duplicate(s)
    half = length(s) ÷ 2
    return getindex(s[1:half] ∩ s[half + 1:end], 1)
end

function get_priority(item)
    islowercase(item) && return Int(item) - 96
    isuppercase(item) && return Int(item) - 38
end

rucksacks = split(input)

# part 1
println("Sum of priorities: ", sum(get_priority.(find_duplicate.(rucksacks))))

# part 2
"""
    find_badge(s)

Find the badge (the unique character) in a group of three rucksacks.
"""
function find_badge(s)
    getindex(s[1] ∩ s[2] ∩ s[3], 1)
end

"""
    group(s, size=3)

Group a vector `s` into groups of `size`.
"""
function group(s, size=3)
    return [s[i:i+2] for i in 1:3:length(s)]
end

println("Sum of priorities: ", sum(get_priority.(find_badge.(group(rucksacks)))))
