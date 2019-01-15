# Theme colors for fzf

_gen_fzf_default_opts() {
  local highlight1="32"
  local foreground1="-1"
  local foreground2="#ffd400"
  local backgorund2="#262626"
  local highlight2="32"
  local info="10"
  local prompt="#00a5ff"
  local spinner=$info
  local pointer="#00a5ff"
  local marker="#00a5ff"

#  export FZF_DEFAULT_OPTS="
#     --color fg:-1,bg:-1,hl:$highlight1,fg+:$foreground,bg+:$backgorund,hl+:$highlight2
#     --color info:$info,prompt:$prompt,pointer:$pointer,marker:$marker,spinner:$spinner
#   "
  export FZF_DEFAULT_OPTS="
    --color=bg+:$backgorund2,bg:-1,spinner:$spinner,hl:$highlight1
    --color=fg:$foreground1,header:$info,info:$info,pointer:$pointer
    --color=marker:$marker,fg+:$foreground2,prompt:$prompt,hl+:$highlight2
  "
}

_gen_fzf_default_opts

