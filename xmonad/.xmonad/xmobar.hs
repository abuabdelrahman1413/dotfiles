Config
  { font = "xft:DejaVu Sans Mono:size=11"
  , additionalFonts = []
  , bgColor = "#1a1b26"
  , fgColor = "#c0caf5"
  , position = Top
  , border = NoBorder
  , borderColor = "#7aa2f7"
  , lowerOnStart = True
  , hideOnStart = False
  , allDesktops = True
  , persistent = True
  , commands =
      [ Run Date "%a %b %d %H:%M" "date" 60
      , Run Battery [] 300
      , Run Memory ["-t","Mem: <usedratio>%"] 60
      , Run Swap [] 60
      , Run Cpu ["-t", "CPU: <total>%"] 30
      , Run Com "uname" ["-r"] "kernel" 36000
      , Run StdinReader
      ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "%StdinReader% }{ %cpu% | %memory% | %battery% | %date%"
  }
