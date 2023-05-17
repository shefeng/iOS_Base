#
# Be sure to run `pod lib lint iOS_Base.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iOS_Base'
  s.version          = '0.0.1'
  s.summary          = 'iOS项目基类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  iOS项目基类
                       DESC

  s.homepage         = 'https://github.com/shefeng/iOS_Base'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shefeng' => 'she.feng@scimall.org.cn' }
  s.source           = { :git => 'https://github.com/shefeng/iOS_Base.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'iOS_Base/Classes/**/*'
  
  # s.resource_bundles = {
  #   'iOS_Base' => ['iOS_Base/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry'
  s.dependency 'AFNetworking'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'SVProgressHUD'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'ZXRequestBlock'
  
end


