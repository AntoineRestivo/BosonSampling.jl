push!(LOAD_PATH, "./src")

using Documenter, BosonSampling

makedocs(
    source = "./src/",
    sitename = "BosonSampling.jl",
    modules = [BosonSampling],
    authors = "Benoit Seron, Antoine Restivo",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "About" => "about.md",
        "Types" => Any[
            "inputs" => "type/input.md",
            "events" => "type/events.md"],
        "Functions" => Any[
            "bunching" => "functions/bunching.md"
        ]
    ]
)

deploydocs(
    repo = "https://github.com/benoitseron/BosonSampling.jl.git"
)
