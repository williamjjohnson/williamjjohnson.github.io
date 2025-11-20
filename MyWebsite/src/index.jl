using Bonito

function index()
    intro = Section(
        DOM.div(
            # Profile picture on left
            DOM.div(
                DOM.img(src=img_asset("profile_picture.jpg")),
                class="profile-picture rotating-frame"
            ),
            # Name on right
            DOM.div(
                DOM.div("William", class="text-4xl font-bold"),
                DOM.div("James", class="text-4xl font-bold"),
                DOM.div("Johnson", class="text-4xl font-bold"),
		DOM.div("PhD Candidate, Environmental Engineering",
		    class="text-lg mt-6"),
                DOM.div("University of Colorado Boulder",
                    class="text-lg"),
                class="flex flex-col justify-center items-start"
            ),
            class="flex flex-col md:flex-row gap-1 items-center"
	),
    )
    
    research = Section(
        FocusBlock(
            "Research Interests",
            DOM.p("""
            In my research, I think about complex risks in the environment and how to measure them. Most recently,
	    I've been studying the hazardous residues released into water resources during wildfire. The animation depicts an analysis of the mobility and toxicity of PAH biotransformation products with increasing reaction depth (blue to yellow). Previously, my work focused on improving wastewater-based surveillance through analysis of collected datasets.
	    """),
            "PAH_video.mp4",  # Your video file
            rev=false,
            is_video=true  # Add this flag
        )
    )
    teaching = Section(
        FocusBlock(
            "Teaching Interests",
	    DOM.p("""
	    I'm passionate about using innovative teaching methods to foster mastery-orientation and
            collaborative learning in the classroom. I am especially interested in game-based and
	    project-based learning styles. The video shows a game I developed to help students understand
            photosynthesis by exploring the interplay between light-dependent and light-independent
            reactions. I've served as a TA for graduate and undergraduate courses in
            Environmental Microbiology (CVEN 4484/5484), Water Chemistry (CVEN 4404), and
            Environmental Organic Chemistry (CVEN 4424).
            """),
            "game_video.mp4",  # Your video file
            rev=true,
            is_video=true  # Add this flag
        )
    )


    contact = Section(
        H2("Get in Touch"),
        DOM.div(
            DOM.p("Feel free to reach out via email or follow my work on the platforms below."),
            DOM.div(
                DOM.a(
                    DOM.i(class="fas fa-envelope"),
                    " wijo3334@colorado.edu",
                    href="mailto:wijo3334@colorado.edu",
                    class="font-bold"
                ),
                DOM.span(" | "),
                DOM.a(
                    DOM.i(class="fab fa-orcid"),
                    " ORCID",
                    href="https://orcid.org/0000-0001-8671-2954",
                    target="_blank"
                ),
		            DOM.span(" | "),
                DOM.a(
                    DOM.i(class="fab fa-google-scholar"),
                    " Google Scholar",
                    href="https://scholar.google.com/citations?user=gxp0ECIAAAAJ",
                    target="_blank"
                ),
                DOM.span(" | "),
                DOM.a(
                    DOM.i(class="fab fa-github"),
                    " GitHub",
                    href="https://github.com/williamjjohnson",
                    target="_blank"
                ),
                class="text-center"
            ),
            class="card"
        )
    )
    return page(DOM.div(intro, research, teaching, contact), "Home")
end
