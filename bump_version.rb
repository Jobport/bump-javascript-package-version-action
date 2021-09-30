#!/usr/bin/env ruby

class Version
  attr_reader :major, :minor, :patch, :special

  def initialize(major = 0, minor = 0, patch = 0, special = "")
    @major = major.to_i
    @minor = minor.to_i
    @patch = patch.to_i
    @special = special.to_s
  end

  def self.parse(string)
    major, minor, rest = string.split('.')
    matchdata = (/(\d+)(\D.*)?/).match(rest)
    patch = matchdata[1]
    special = matchdata[2].to_s
    raise ArgumentError, 'invalid major version' unless major =~ /^\d+$/
    raise ArgumentError, 'invalid minor version' unless minor =~ /^\d+$/
    raise ArgumentError, 'invalid patch version' unless patch =~ /^\d+$/
    raise ArgumentError, 'invalid special version' unless special.empty? || special =~ /^[A-Za-z]/

    new(major.to_i, minor.to_i, patch.to_i, special)
  end

  def to_s
    "#{major}.#{minor}.#{patch}#{special}"
  end

  def bump(level)
    case level.downcase
    when 'major' then next_major_version
    when 'minor' then next_minor_version
    when 'patch' then next_patch_version
    else
      raise "What do you mean with #{level}!?"
    end
  end

  def next_major_version
    self.class.new(major + 1, minor, patch)
  end

  def next_minor_version
    self.class.new(major, minor + 1, patch)
  end

  def next_patch_version
    self.class.new(major, minor, patch + 1)
  end
end

current_version = Version.parse(ARGV.shift)
level = ARGV.shift
puts current_version.bump(level)
