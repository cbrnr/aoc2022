include("utils.jl")

cookie = ""
input = get_aoc_input(11, cookie)

mutable struct Monkey
    items::Vector{Int}
    operation::Function
    divisible::Int
    yes::Int
    no::Int
    i::Int
end

function make_operation(expr)
    return eval(:(old -> $expr))
end

function parse_input(input)
    monkeys = []
    for item in split(strip(input), "\n\n")
        parts = split(item, "\n")
        items = [parse(Int, m.match) for m in eachmatch(r"(\d+)", parts[2])]
        operation = make_operation(Meta.parse(split(parts[3], " = ")[end]))
        divisible = parse(Int, match(r"(\d+)", parts[4]).match)
        yes = parse(Int, match(r"(\d+)", parts[5]).match) + 1
        no = parse(Int, match(r"(\d+)", parts[6]).match) + 1
        push!(monkeys, Monkey(items, operation, divisible, yes, no, 0))
    end
    return monkeys
end

monkeys = parse_input(input)

# part 1
for round in 1:20
    for monkey in monkeys
        for item in monkey.items
            new = monkey.operation(item) ÷ 3
            next = new % monkey.divisible == 0 ? monkey.yes : monkey.no
            push!(monkeys[next].items, new)
        end
        monkey.i += length(monkey.items)
        monkey.items = []
    end
end

sort!(monkeys, by=x -> x.i)
println("Monkey business: ", monkeys[end-1].i * monkeys[end].i)

# part 2
monkeys = parse_input(input)
factors = prod([monkey.divisible for monkey in monkeys])

for round in 1:10000
    for monkey in monkeys
        for item in monkey.items
            new = monkey.operation(item) % factors
            next = new % monkey.divisible == 0 ? monkey.yes : monkey.no
            push!(monkeys[next].items, new)
        end
        monkey.i += length(monkey.items)
        monkey.items = []
    end
end

sort!(monkeys, by=x -> x.i)
println("Monkey business: ", monkeys[end-1].i * monkeys[end].i)
