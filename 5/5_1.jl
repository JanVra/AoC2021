coords = readlines("5/coords.txt")

mutable struct Point
    x::Int
    y::Int
end
Point(x::AbstractString, y::AbstractString) = begin
    x = parse(Int, x)
    y = parse(Int, y)
    return Point(x, y)
end

mutable struct Line
    point_begin::Point
    point_end::Point
end

function path(line::Line)
    path = []
    x_anf = min(line.point_begin.x, line.point_end.x)
    y_anf = min(line.point_begin.y, line.point_end.y)
    x_anf = max(line.point_begin.x, line.point_end.x)
    y_anf = max(line.point_begin.y, line.point_end.y)
    if (line.point_begin.x == line.point_end.x) | (line.point_begin.y == line.point_end.y)
        for x in line.point_begin.x:line.point_end.x
            for y in line.point_begin.y:line.point_end.y
                push!(path, Point(x, y))
            end
        end
    end
    return path
end

function map_line!(line::Line, map_matrix)
    for points in path(line)
        map_matrix[points.x+1, points.y+1] += 1
    end
    return map_matrix
end

function parse_coordinates(coords)
    lines = []
    for coord_line in coords
        points = split(coord_line, " -> ")
        beginning, ending = split.(points, ",")
        line = Line(Point(beginning...), Point(ending...))
        push!(lines, line)
    end
    return lines
end

function main(coords)
    lines = parse_coordinates(coords)
    map_matrix = zeros(Int, (10,10))
    for line in lines
        map_line!(line, map_matrix)
    end
    return map_matrix
end

count(>=(2), main(coords))