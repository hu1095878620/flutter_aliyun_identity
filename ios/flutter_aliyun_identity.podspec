#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_aliyun_identity.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_aliyun_identity'
  s.version          = '0.0.1'
  s.summary          = '阿里云人脸识别SDK'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/*.{h,m}', 'Classes/AliyunFramework/**/*.{h}'
  s.public_header_files = 'Classes/*.h'

  s.resources = 'Assets/*'
  s.vendored_frameworks = 'Classes/AliyunFramework/*.framework'
  s.frameworks = 'CoreGraphics', 'Accelerate', 'SystemConfiguration', 'AssetsLibrary', 'CoreTelephony', 'QuartzCore', 'CoreFoundation', 'CoreLocation', 'ImageIO', 'CoreMedia', 'CoreMotion', 'AVFoundation', 'WebKit', 'AudioToolbox', 'CFNetwork', 'MobileCoreServices', 'AdSupport'
  s.libraries = 'resolv', 'z', 'c++', 'c++.1', 'c++abi', 'z.1.2.8'

  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
