include("utils.jl")

cookie = ""
input = get_aoc_input(8, cookie)

grid = permutedims(parse.(Int, hcat(collect.(split(strip(input)))...)))

"""
    is_visible(trees)

Determine visible trees (from the left) in a one-dimensional array.
"""
function is_visible(trees)
    visible = zeros(Bool, size(trees))
    highest = -1
    for i in eachindex(trees)
        if trees[i] == maximum(trees)
            visible[i] = true
            return visible
        end
        if trees[i] > highest
            highest = trees[i]
            visible[i] = true
        end
    end
    return visible
end

flipud(x) = reverse(x, dims=1)
fliplr(x) = reverse(x, dims=2)

function count_visible_trees(grid)
    left = permutedims(hcat(is_visible.(collect(eachrow(grid)))...))
    right = fliplr(permutedims(hcat(is_visible.(collect(eachrow(fliplr(grid))))...)))
    top = hcat(is_visible.(collect(eachcol(grid)))...)
    bottom = flipud(hcat(is_visible.(collect(eachcol(flipud(grid))))...))
    return sum(left .| right .| top .| bottom)
end

# part 1
println("Visible trees: ", count_visible_trees(grid))

# part 2
function scenic_scores(grid)
    scores = zero(grid)
    for i in CartesianIndices(grid)
        r, c = Tuple(i)

        # look up
        up = 0
        if r > 1
            for tree in grid[r-1:-1:1, c]
                up += 1
                tree >= grid[r, c] && break
            end
        end

        # look down
        down = 0
        if r < size(grid, 1)
            for tree in grid[r+1:end, c]
                down += 1
                tree >= grid[r, c] && break
            end
        end

        # look right
        right = 0
        if c < size(grid, 2)
            for tree in grid[r, c+1:end]
                right += 1
                tree >= grid[r, c] && break
            end
        end

        # look left
        left = 0
        if c > 1
            for tree in grid[r, c-1:-1:1]
                left += 1
                tree >= grid[r, c] && break
            end
        end
        scores[r, c] = up * down * right * left
    end
    return scores
end

println("Highest scenic score: ", maximum(scenic_scores(grid)))
