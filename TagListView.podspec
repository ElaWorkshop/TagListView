Pod::Spec.new do |s|
  s.name         = "TagListView"
  s.version      = "0.2"
  s.summary      = "Simple but highly customizable iOS tag list view, in Swift."
  s.homepage     = "https://github.com/xhacker/TagListView"
  s.social_media_url = "https://twitter.com/xhacker"

  s.license      = "MIT"
  s.author       = { "LIU Dongyuan" => "liu.dongyuan@gmail.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/xhacker/TagListView.git", :tag => "0.2" }
  s.source_files = "TagListView/*.swift"
  s.requires_arc = true
end
