Pod::Spec.new do |s|
  s.name             = "JGString"
  s.version          = "1.0.0"
  s.summary          = "A lightweight string extension for Swift"

  s.description      = <<-DESC
                        Common methods and String operations for Swift
                       DESC

  s.homepage         = "https://github.com/JanyGee/JGString"
  s.license          = 'MIT'
  s.author           = { "Andrew Mayne" => "1321899953@qq.com" }
  s.source           = { :git => "https://github.com/JanyGee/JGString.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/amayne'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end