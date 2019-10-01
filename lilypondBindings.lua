-- using shell script to load Green because Micros RUN command have troubles with
-- SDL_NOMOUSE=1 parameter
pdf_command = "./pdfprev.sh"
-- mid_command = "fluidsynth -i -o audio.driver=alsa /usr/share/sounds/sf2/FluidR3_GM.sf2"
mid_command = "timidity"
mid_extension = ".midi"
-- pdf_command = "SDL_NOMOUSE=1 ./green" .. file_pdf

function compileScore()
    local file_ly = CurView().Buf.Path
    local file_pdf = string.gsub(CurView().Buf.Path,".ly","")
    HandleCommand("run lilypond --output " .. file_pdf .. " " .. file_ly)
end

function prevScore()
    local file_pdf = string.gsub(CurView().Buf.Path,".ly",".pdf")
    HandleCommand("run " .. pdf_command .. " " .. file_pdf)
end

function playScore()
    local file_mid = string.gsub(CurView().Buf.Path,".ly",mid_extension)
    HandleCommand("run " .. mid_command .. " " .. file_mid)
end

MakeCommand("playscore", "lilypondBindings.playScore", 0)
MakeCommand("compscore", "lilypondBindings.compileScore", 0)
MakeCommand("prevscore", "lilypondBindings.prevScore", 0)
BindKey("F5", "command:compscore")
BindKey("F6", "command:prevscore")
BindKey("F7", "command:playscore")
