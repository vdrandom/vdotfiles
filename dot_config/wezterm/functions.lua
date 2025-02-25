local function get_os()
    local current_os = os.getenv('OS')
    if current_os then return current_os end
    return io.popen('uname -s', 'r'):read()
end

local function set_by_os(values)
    if values[MY_OS] then return values[MY_OS] end
    return values.others
end

MY_OS = get_os()

return {
    set_by_os = set_by_os
}
