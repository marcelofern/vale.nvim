local config = {}

local defaults = {
  bin="vale",
  vale_config_path="$HOME/.config/vale/vale.ini",
}

ValeGlobalConfig = ValeGlobalConfig or defaults

function config.set_bin(bin)
  ValeGlobalConfig["bin"] = bin
end

function config.set_vale_config_path(vale_config_path)
  ValeGlobalConfig["vale_config_path"] = vale_config_path
end

function config.get_bin()
  return ValeGlobalConfig["bin"]
end

function config.get_vale_config_path()
  return ValeGlobalConfig["vale_config_path"]
end

return config
