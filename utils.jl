using HTTP

"""
    get_aoc_input(day, cookie)

Download Advent of Code 2022 input data for the given `day`.

A valid `cookie` must be provided, for example by logging into the
[Advent of Code website](https://adventofcode.com/2022) with a browser and copying the
session cookie (accessible in the browser preferences).
"""
function get_aoc_input(day::Integer, cookie::AbstractString)
    cookies = Dict("session"=>cookie)
    r = HTTP.get("https://adventofcode.com/2022/day/$day/input", cookies=cookies)
    String(r.body)
end
