require 'komodo_dragon/version'
require 'komodo_dragon/monitor'

def monitor_libraries(libraries=[])
  KomodoDragon::Monitor.start(libraries)
end
