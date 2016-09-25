Pod::Spec.new do |s|
  s.name         = "JSONValue"
  s.version      = "2.0"
  s.summary      = "Simple, type-safe JSON object representations!"

  s.description  = <<-DESC
JSONValue is a simple enum that provides type-safe JSON data access. It incorporates all of the JSON types and provides example syntax on how to best access them. It supports easy null checking while preventing you from having to specify optionals.
		      DESC

  s.homepage     = "https://github.com/Weebly/JSONValue"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "James Richard" => "james@weebly.com" }
  s.social_media_url   = "http://twitter.com/ketzusaka"
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.source       = { :git => "https://github.com/Weebly/JSONValue.git", :tag => "v2.0" }
  s.source_files  = 'JSONValue/JSONValue.swift', 'JSONValue/JSONValueCoder.swift', 'JSONValue/JSONValueJSONDataCoder.swift'
  s.requires_arc = true
end

