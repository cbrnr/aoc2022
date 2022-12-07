include("utils.jl")

cookie = ""
input = get_aoc_input(7, cookie)

function total_size(path, tree)
    s = 0
    for (k, v) in tree
        if startswith(k, path)
            s += sum(v)
        end
    end
    return s
end

function parse_input(input)
    tree = Dict{String, Vector{Integer}}()
    cwd = []  # current working directory
    for line in input
        if startswith(line, raw"$ ")  # command
            if startswith(line[3:end], "cd")  # change directory
                if line[6:end] == ".."  # move out
                    pop!(cwd)
                else  # move in
                    push!(cwd, line[6:end])
                    tree[abspath(cwd...)] = []
                end
            end
        else  # contents (file or directory)
            size, _ = split(line)
            if size != "dir"  # add file size
                push!(tree[abspath(cwd...)], parse(Int, size))
            end
        end
    end
    return Dict(k => total_size(k, tree) for (k, v) in tree)
end

tree = parse_input(split(strip(input), "\n"))

# part 1
total = 0
for v in values(tree)
    if v <= 100000
        total += v
    end
end

println("Sum of total sizes: ", total)

# part 2
const DISK_SIZE = 70_000_000
const NEEDED_SIZE = 30_000_000
unused = DISK_SIZE - tree["/"]

free_size = DISK_SIZE
for v in values(tree)
    if v >= (NEEDED_SIZE - unused) && (v < free_size)
        free_size = v
    end
end

println("Size of smallest directory: ", free_size)
