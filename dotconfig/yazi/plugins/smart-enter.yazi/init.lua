return {
  entry = function ()
    local h = cx.active.current.hovererd
    ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
  end,
}