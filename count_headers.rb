#!/usr/bin/env ruby

if ARGV.size() <= 1 || ! FileTest.file?(ARGV[0])
  puts "Usage: #{File.basename($0)} file header [header ...]"
  exit(2)
end

# Initialize
filename = ARGV.shift

counter = {}
ARGV.each { |arg| counter[arg] = 0 }

# Count
largestHeader = 0 # for tabular printing
highestCount  = 0 # for tabular printing

File.open(filename) do |file|
  file.each do |line|
    header = line.split(':', 2).first

    if header and counter.has_key?(header)
      largestHeader = header.length if header.length > largestHeader
      counter[header] += 1
    end
  end
end

# Print
format = "%#{largestHeader}s\t%#{highestCount}s\n"
printf(format, "Header", "Count")
printf(format, "------", "-----")

counter.each_pair do |header, count|
  printf(format, header, count)
end
