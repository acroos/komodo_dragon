module KomodoDragon
  require 'thread'
  class Monitor
    def self.start(libraries=[])
      self.new(libraries).start
    end
    INTERVAL=1
    def initialize(libraries=[])
      @files = libraries.map {|i| "#{Dir.pwd}/#{i}.rb"}
      @file_mtimes = {}
    end

    def start
      @thread = Thread.new do
        loop do
          update_mtimes
          sleep INTERVAL
        end
      end
    end

    def update_mtimes
      @files.each {|file| update_mtime(file)}
    end

    def update_mtime(file)
      raise "File #{file} does not exist" unless File.exist?(file)
      mtime = @file_mtimes[file]
      curtime = File.mtime(file)
      unless mtime
        load file
      end

      if mtime && mtime < curtime
        load file
      end
      @file_mtimes[file] = curtime
    end
  end
end
