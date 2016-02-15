#
# Be sure to run `pod lib lint GhostLoginManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GhostLoginManager"
  s.version          = "0.4.0"
  s.summary          = "A client library to log into an installation of Ghost"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  GhostLoginManager is an Swift client for the Ghost authentication API. 
                       DESC

  s.homepage         = "https://github.com/kerrmarin/GhostLoginManager"
  s.license          = 'MIT'
  s.author           = { "Kerr Marin Miller" => "kerr@kerrmarin.com" }
  s.source           = { :git => "https://github.com/kerrmarin/GhostLoginManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kerrmarin'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GhostLoginManager' => ['Pod/Assets/*.png']
  }

  s.dependency 'Alamofire', '~> 3.0'
end
