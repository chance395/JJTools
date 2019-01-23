
Pod::Spec.new do |s|

  s.name         = "JJTools"
  s.version      = "0.0.7"
  s.summary      = "some others useful tools "
  s.description  = <<-DESC 
include some category based on masonry for create UI  and some others useful tools
                   DESC
  s.homepage     = "https://github.com/chance395/JJTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Brain" => "895176298@qq.com" }
  s.ios.deployment_target = "8.0"


  s.source       = { :git => "https://github.com/chance395/JJTools.git", :tag => "v#{s.version}" }


   s.source_files  = "Classes", "JJTools/JJTools/Classes/**/*.{h,m}"
   s.public_header_files = "JJTools/JJTools/Classes/JJBaseHeader.h"

  s.frameworks = "UIKit", "Foundation","CoreLocation","Photos","SystemConfiguration","Security","CoreFoundation"
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto" }
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/sys" }
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/objc" }

   s.dependency 'Masonry'
   s.dependency 'AFNetworking'
   #s.dependency 'MBProgressHUD'


s.requires_arc = true




end
