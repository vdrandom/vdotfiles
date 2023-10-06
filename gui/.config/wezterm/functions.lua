local function get_os()
    local current_os = os.getenv('OS')
    if current_os then return current_os end
    return io.popen('uname -s', 'r'):read()
end

local function set_by_os(values)
    local my_os = get_os()
    if values[my_os] then return values[my_os] end
    return values.others
end

return {
    set_by_os = set_by_os
}
