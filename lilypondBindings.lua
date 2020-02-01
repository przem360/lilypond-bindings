-- using shell script to load Green because Micros RUN command have troubles with
-- SDL_NOMOUSE=1 parameter
pdf_command = "./pdfprev.sh"
-- mid_command = "fluidsynth -i -o audio.driver=alsa /usr/share/sounds/sf2/FluidR3_GM.sf2"
mid_command = "timidity --config-file=./timidity_custom.cfg --adjust-tempo=180 --reverb=g,80 --noise-shaping=3"
mid_extension = ".midi"
playback_on = 0
-- pdf_command = "SDL_NOMOUSE=1 ./green" .. file_pdf

function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
 end

function compileScore()
    local current = CurView().Buf.Path
    if ends_with(CurView().Buf.Path, '.ly') then
        local file_pdf = string.gsub(CurView().Buf.Path,".ly","")
        HandleCommand("run lilypond --output " .. file_pdf .. " " .. current)
    elseif ends_with(CurView().Buf.Path, '.abc') then
        local file_ps = string.gsub(CurView().Buf.Path,".abc","")
        HandleCommand("run abcm2ps " .. current .. " -O " .. file_ps .. ".ps")
        HandleCommand("run ps2pdfwr " .. file_ps .. ".ps " .. file_ps .. ".pdf")
        HandleCommand("run abc2midi " .. current .. " -o " .. file_ps .. mid_extension)
    end
end

function prevScore()
    if ends_with(CurView().Buf.Path, '.ly') then
        file_pdf = string.gsub(CurView().Buf.Path,".ly",".pdf")
    elseif ends_with(CurView().Buf.Path, '.abc') then
        file_pdf = string.gsub(CurView().Buf.Path,".abc",".pdf")
    end
    HandleCommand("run " .. pdf_command .. " " .. file_pdf)
end

function playScore()
    if ends_with(CurView().Buf.Path, '.ly') then
        file_mid = string.gsub(CurView().Buf.Path,".ly",mid_extension)
    elseif ends_with(CurView().Buf.Path, '.abc') then
        file_mid = string.gsub(CurView().Buf.Path,".abc",mid_extension)
    end
    if playback_on > 0 then
        HandleCommand("run pkill timidity")
        playback_on = 0
    else
        HandleCommand("run " .. mid_command .. " " .. file_mid)
        playback_on = 1
    end
end

function renderWave()
    if ends_with(CurView().Buf.Path, '.ly') then
        file_mid = string.gsub(CurView().Buf.Path,".ly",mid_extension)
    elseif ends_with(CurView().Buf.Path, '.abc') then
        file_mid = string.gsub(CurView().Buf.Path,".abc",mid_extension)
    end
    HandleCommand("run " .. mid_command .. " " .. file_mid .. " -Ow")
end

MakeCommand("playscore", "lilypondBindings.playScore", 0)
MakeCommand("compscore", "lilypondBindings.compileScore", 0)
MakeCommand("prevscore", "lilypondBindings.prevScore", 0)
MakeCommand("renderwav", "lilypondBindings.renderWave", 0)
BindKey("F5", "command:compscore")
BindKey("F6", "command:prevscore")
BindKey("F7", "command:playscore")
BindKey("F8", "command:renderwav")