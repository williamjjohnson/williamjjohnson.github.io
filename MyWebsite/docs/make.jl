using MyWebsite, Bonito
dir = joinpath(@__DIR__, "..", "..")
!isdir(dir) && mkdir(dir)
Bonito.export_static(dir, create_routes())
