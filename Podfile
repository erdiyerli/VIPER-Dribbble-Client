platform :ios, '9.0'

use_frameworks!

def common_pods
  pod 'OAuthSwift', '~> 0.5.0'
  pod 'ObjectMapper', '~> 1.3'
  pod 'Kingfisher', '~> 2.4'
  pod 'SVPullToRefresh'
  pod 'Fuzi', '~> 0.3.0'
end

target 'DribbbleClient'  do
  common_pods
end

target 'DribbbleClientTests'  do
  common_pods
  
  pod 'Quick'
  pod 'Nimble'
end
