include("utils.jl")

cookie = ""
input = get_aoc_input(2, cookie)

strategy = split.(split(strip(input), "\n"))

function score(game; mode=:part1)
    points = 0
    other, self = game
    other = replace.(other, "A" => "Rock", "B" => "Paper", "C" => "Scissors")
    wins = Dict("Rock" => "Scissors", "Scissors" => "Paper", "Paper" => "Rock")

    if mode == :part1
        self = replace(self, "X" => "Rock", "Y" => "Paper", "Z" => "Scissors")
    elseif mode == :part2
        if self == "X"  # need to lose
            self = wins[other]
        elseif self == "Y"  # need a draw
            self = other
        else  # need to win
            self = Dict(wins[k] => k for k in keys(wins))[other]
        end
    end

    if self == "Rock"
        points += 1
    elseif self == "Paper"
        points += 2
    else
        points += 3
    end

    if (self, other) in zip(keys(wins), values(wins))  # win
        points += 6
    elseif other == self  # draw
        points += 3
    end
    return points
end

# part 1
println("Score: ", sum(score.(strategy)))

# part 2
println("Score: ", sum(score.(strategy, mode=:part2)))
