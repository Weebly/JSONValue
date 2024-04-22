Pod::Spec.new do |s|
  s.name         = "JSONValue"
  s.version      = "3.0.2"
  s.summary      = "Simple, type-safe JSON object representations!"

  s.description  = <<-DESC
JSONValue is a simple enum that provides type-safe JSON data access. It incorporates all of the JSON types and provides example syntax on how to best access them. It supports easy null checking while preventing you from having to specify optionals.
		      DESC

  s.homepage     = "https://github.com/Weebly/JSONValue"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jace Conflenti" => "jace@squareup.com" }
  s.social_media_url   = "http://twitter.com/ketzusaka"
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'
  s.source       = { :git => "https://github.com/Weebly/JSONValue.git", :tag => "v3.0.2" }
  s.source_files  = 'JSONValue/JSONValue.swift', 'JSONValue/JSONValueCoder.swift', 'JSONValue/JSONValueJSONDataCoder.swift'
  s.resource_bundles = {'JSONValue_privacy' => ['JSONValue/PrivacyInfo.xcprivacy']}
  s.requires_arc = true
  s.swift_version = "5.0"
end

