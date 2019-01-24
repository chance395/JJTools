
Pod::Spec.new do |s|

  s.name         = "JJTools"
  s.version      = "1.0.5"
  s.summary      = "some others useful tools "
  s.description  = <<-DESC 
include some category based on masonry for create UI  and some others useful tools
                   DESC
  s.homepage     = "https://github.com/chance395/JJTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Brain" => "895176298@qq.com" }
  s.ios.deployment_target = "8.0"


  s.source       = { :git => "https://github.com/chance395/JJTools.git", :tag => "v#{s.version}" }


   #s.source_files  = 'JJTools/JJTools/Classes/**/*'
   #s.public_header_files = 'JJTools/JJTools/Classes/JJBaseHeader.h'

  s.frameworks = "UIKit", "Foundation","CoreLocation","Photos","SystemConfiguration","Security","CoreFoundation","WebKit"
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto" }
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/sys" }
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/objc" }

   s.dependency 'Masonry'
   s.dependency 'AFNetworking'
   s.dependency 'MBProgressHUD'


s.requires_arc = true

s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

  s.subspec 'Dispatch_Queue' do |ss|

  ss.source_files = 'JJTools/JJTools/Classes/Dispatch_Queue/*.{h,m}'
   
  end

 s.subspec 'JJModel' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJModel/*'
  
  end

 s.subspec 'JJBaseViewController' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJBaseViewController/*'
   ss.dependency 'JJTools/JJDefine'
   #ss.dependency 'JJTools/JJBaseView'

  end

 s.subspec 'JJTool' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJTool/*'
   ss.dependency 'JJTools/JJDefine'
   ss.dependency 'JJTools/JJBaseViewController'

  end

 s.subspec 'JJNetWork' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJNetWork/*'
   ss.dependency 'JJTools/JJDefine'
  ss.dependency 'JJTools/JJTool'
  ss.dependency 'JJTools/JJCategory'

  end


 s.subspec 'JJDefine' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJDefine/*'
  end

s.subspec 'JJBaseView' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJBaseView/*'
   ss.dependency 'JJTools/JJDefine'
   ss.dependency 'JJTools/JJCategory'
   ss.dependency 'JJTools/JJNetWork'
   ss.dependency 'JJTools/JJUILayout'

  end

 s.subspec 'JJSystem' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJDefine/*'

  end

 s.subspec 'JJCategory' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJCategory/*'

  end

 s.subspec 'JJUILayout' do |ss|
  ss.source_files = 'JJTools/JJTools/Classes/JJUILayout/*'  
 ss.dependency 'JJTools/JJCategory'

  end



end
