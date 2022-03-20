do
    local x = 0

    function conky_cpu_temp()
        return tonumber(conky_parse("${hwmon coretemp temp 1}"))
    end
end
