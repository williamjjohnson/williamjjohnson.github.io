module MyWebsite

using Bonito, Markdown
import Bonito.TailwindDashboard as D

function asset_path(files...)
    path = normpath(joinpath(@__DIR__, "..", "assets", files...))
    return path
end

function create_routes()
    return Routes(
        "/" => App(index, title="Home"),
    )
end

img_asset(files...) = Asset(asset_path("images", files...))

include("styles.jl")
include("index.jl")

function asset_paths()
    return [@__DIR__, asset_path(), asset_path("images"), asset_path("css")]
end

export index, website_styles, create_routes, asset_paths

end
