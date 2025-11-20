using Bonito

const COLORS = (
    primary = "#2196F3",
    primary_dark = "#1565C0",
    text = "#212121",
    gray_100 = "#F5F5F5",
    gray_600 = "#757575",
    white = "#FFFFFF",
)

function website_styles()
    return Styles(
        # Base styles
        CSS("*, ::before, ::after",
            "box-sizing" => "border-box",
            "border-width" => "0",
            "border-style" => "solid"
        ),

        CSS("body",
            "width" => "100%",
            "background-color" => "rgb(255, 255, 255)",
            "margin" => "0",
            "line-height" => "1.5",
            "font-family" => "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
            "font-size" => "1rem",
            "color" => COLORS.text
        ),

        CSS("img, video",
            "max-width" => "100%",
            "height" => "auto"
        ),

        # Layout utilities
        CSS(".flex", "display" => "flex"),
        CSS(".flex-col", "flex-direction" => "column"),
        CSS(".items-center", "align-items" => "center"),
        CSS(".justify-center", "justify-content" => "center"),
        CSS(".gap-4", "gap" => "1rem"),
        CSS(".gap-6", "gap" => "1.5rem"),

        # Spacing
        CSS(".p-4", "padding" => "1rem"),
        CSS(".p-8", "padding" => "2rem"),
        CSS(".my-4", "margin-top" => "1rem", "margin-bottom" => "1rem"),
        CSS(".my-8", "margin-top" => "2rem", "margin-bottom" => "2rem"),
	CSS(".mt-6", "margin-top" => "1.5rem"),

        # Width
        CSS(".w-full", "width" => "100%"),
        CSS(".max-w-4xl", "max-width" => "56rem"),
        CSS(".max-w-prose", "max-width" => "65ch"),

        # Typography
        CSS(".text-xl", "font-size" => "1.25rem", "line-height" => "1.75rem"),
	CSS(".text-4xl", "font-size" => "2.25rem", "line-height" => "2.5rem"),
        CSS(".text-lg", "font-size" => "1.125rem", "line-height" => "1.75rem"),
        CSS(".text-base", "font-size" => "1rem", "line-height" => "1.5rem"),
        CSS(".font-bold", "font-weight" => "700"),
        CSS(".text-center", "text-align" => "center"),
        CSS(".text-justify", "text-align" => "justify"),

        # Colors
        CSS(".text-white", "color" => COLORS.white),
        CSS(".bg-gray-100", "background-color" => COLORS.gray_100),

        # Card
        CSS(".card",
            "background-color" => COLORS.white,
            "border-radius" => "0.5rem",
            "padding" => "1rem",
            "box-shadow" => "0 2px 8px rgba(0, 0, 0, 0.1)"
        ),

        # Navbar
        CSS(".navbar",
            "background" => "linear-gradient(135deg, $(COLORS.primary) 0%, $(COLORS.primary_dark) 100%)",
            "padding" => "1rem",
            "box-shadow" => "0 2px 12px rgba(0, 0, 0, 0.15)"
        ),

        CSS(".navbar a",
            "color" => COLORS.white,
            "text-decoration" => "none",
            "padding" => "0.5rem 1rem",
            "transition" => "opacity 0.2s"
        ),

        CSS(".navbar a:hover",
            "opacity" => "0.7"
        ),

        # Links
        CSS("a",
            "color" => COLORS.primary,
            "text-decoration" => "none"
        ),

        CSS("a:hover",
            "text-decoration" => "underline"
        ),

	# Responsive
        CSS("@media (min-width: 768px)",
            CSS(".md\\:flex-row", "flex-direction" => "row"),
            CSS(".md\\:flex-row-reverse", "flex-direction" => "row-reverse"),
            CSS(".md\\:gap-8", "gap" => "2rem"),
            CSS(".md\\:w-3\\/5", "width" => "60%"),
            CSS(".md\\:w-2\\/5", "width" => "40%"),
        ),

        # Profile picture with rotating frame
        CSS(".profile-picture.rotating-frame",
            "width" => "200px",
            "height" => "200px",
            "border-radius" => "50%",
            "position" => "relative",
            "overflow" => "hidden",
            "margin" => "0 auto"
        ),

       CSS(".profile-picture.rotating-frame::before",
            "content" => "''",
            "position" => "absolute",
            "top" => "-50%",
            "left" => "-50%",
            "width" => "200%",
            "height" => "200%",
            "background" => "conic-gradient(from 0deg, transparent 0deg 45deg, #6ba3c9 45deg 135deg, transparent 135deg 225deg, #3498db 225deg 315deg, transparent 315deg 360deg)",
            "animation" => "rotate 45s linear infinite",
            "z-index" => "0"
        ),

        CSS(".profile-picture.rotating-frame img",
            "position" => "absolute",
            "top" => "5px",
            "left" => "5px",
            "width" => "calc(100% - 10px)",
            "height" => "calc(100% - 10px)",
	    "max-width" => "none",
            "border-radius" => "50%",
            "object-fit" => "cover"
        ), 
    )
end

# Helper components
H1(x) = DOM.h1(x; class="text-xl font-bold my-4")
H2(x) = DOM.h2(x; class="text-lg font-bold my-4")

function Section(content...; kwargs...)
    outer_class = get(kwargs, :class, "")
    full_class = "flex flex-col items-center w-full $outer_class"
    DOM.div(
        DOM.div(content...; class="max-w-4xl w-full p-4"),
        class=full_class
    )
end

function Navigation(highlighted="")
    function item(name, href)
        class = highlighted == name ? "font-bold" : ""
        return DOM.a(name; href=href, class=class)
    end

    return DOM.div(
        DOM.div(
            item("Home", "/"),
            DOM.span(" | "; class="text-white"),
	    DOM.a("Curriculum Vitae", href=Asset(asset_path("images", "curriculumvitae.pdf")), target="_blank", class=""),
            class="flex gap-3 items-center"
        );
        class="navbar flex justify-center"
    )
end

function page(body, highlighted)
    # Raw CSS for keyframes animation (Bonito's CSS() doesn't handle @keyframes well)
    keyframes_style = DOM.style("""
        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    """)
    
    # Font Awesome CDN
    fontawesome = DOM.link(
        rel="stylesheet",
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    )
    
    return DOM.html(
        DOM.head(
            DOM.meta(name="viewport", content="width=device-width, initial-scale=1.0"),
            DOM.meta(charset="utf-8"),
            DOM.title("William J. Johnson"),
            website_styles(),
            keyframes_style,
	    fontawesome
        ),
        DOM.body(
            Navigation(highlighted),
            body
        )
    )
end

function FocusBlock(title, text, media; rev=false, is_video=false)
    media_element = if is_video
        DOM.video(
            DOM.source(src=img_asset(media), type="video/mp4"),
            muted=true,
            autoplay=true,
            loop=true,
            controls=false,
            class="card w-full"
        )
    else
        DOM.img(src=img_asset(media), class="card w-full")
    end
    
    content = DOM.div(
        H2(title),
        DOM.div(text, class="card"),
        class="w-full md:w-3/5"
    )
    img_div = DOM.div(media_element, class="w-full md:w-2/5")
    
    direction = rev ? "md:flex-row-reverse" : "md:flex-row"
    
    return DOM.div(
        content,
        img_div,
        class="flex flex-col $direction gap-6 items-center w-full"
    )
end

export H1, H2, Section, Navigation, page, COLORS, FocusBlock
