using MyWebsite, Bonito

dir = joinpath(@__DIR__, "build")
!isdir(dir) && mkdir(dir)

Bonito.export_static(dir, create_routes())

