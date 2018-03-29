
Pod::Spec.new do |s|

  s.name         = "CJLocationManager"
  s.version      = "1.0.0"
  s.summary      = "A commonly used positioning tool."
  s.description  = "That is commonly used in project positioning tools, support a one-time positioning, frequent positioning, etc"

  s.homepage     = "https://github.com/dreamCC/CJLocationManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "dreamCC" => "568644031@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dreamCC/CJLocationManager.git", :tag => 1.0.0 }
  s.requires_arc = true  
  s.source_files = "CJLocationManager/*.{h,m}"
end
