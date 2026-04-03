Pod::Spec.new do |s|
  s.name             = "JGString"
  s.version          = "1.0.2"
  s.summary          = "Swift string utilities for slugify, camelize, trim, initials, HTML decode, and parsing"

  s.description      = <<-DESC
                        JGString is a lightweight Swift string utilities library that adds practical String helpers for
                        slugify, camelize, whitespace trimming, initials extraction, HTML entity decoding, prefix and
                        suffix handling, and converting strings into numbers, booleans, and dates.
                       DESC

  s.homepage         = "https://github.com/JanyGee/JGString"
  s.license          = 'MIT'
  s.author           = { "Jany" => "1321899953@qq.com" }
  s.source           = { :git => "https://github.com/JanyGee/JGString.git", :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.requires_arc = true
  s.swift_version = '5.9'

  s.source_files = 'Pod/Classes/**/*.swift'
end
