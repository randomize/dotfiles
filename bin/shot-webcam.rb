#!/usr/bin/env ruby

require 'fileutils'

fswebcam_path = `which fswebcam`.strip
exit 0 if fswebcam_path.empty?

print "Snapshotting your pretty mug..."

base_path = File.expand_path("~/.gitshots")
file = File.join(base_path, "#{Time.now.to_f}.png")

FileUtils.mkdir_p(base_path)
system("#{fswebcam_path} --png -1 --save #{file} -q")

puts "Done"

exit 0
