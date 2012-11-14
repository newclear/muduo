function defaultaction(osName, actionName)
    if actionName == nil then
        _ACTION = _ACTION or osName;
    end
    if os.is(osName) then
        _ACTION = _ACTION or actionName;
    end
end
