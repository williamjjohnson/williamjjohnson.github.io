using Revise, MyWebsite, Bonito
routes, task, server = interactive_server(MyWebsite.asset_paths()) do
    create_routes()
end
