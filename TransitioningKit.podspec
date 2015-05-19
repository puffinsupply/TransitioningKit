Pod::Spec.new do |s|
  s.name     = "TransitioningKit"
  s.version  = "0.1"
  s.summary  = "A Swift framework for simplifying, clarifying, & standardizing custom navigation & view controller transitions."
  s.license  = { :type => "MIT", :file => "LICENSE" }

  s.homepage = "https://github.com/puffinsupply/TransitioningKit"
  s.author   = { "Adam Michela" => "desk@miche.la" }
  s.source   = { :git => "https://github.com/puffinsupply/TransitioningKit.git", :tag => "#{s.version}" }
  s.source_files = "TransitioningKit/*.swift"
  s.ios.deployment_target = "8.0"
  s.requires_arc = true
end
