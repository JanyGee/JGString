Pod::Spec.new do |s|
  s.name             = "JGString"
  s.version          = "1.0.2"
  s.summary          = "A lightweight string extension for Swift"

  s.description      = <<-DESC
                        Common methods and String operations for Swift
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
