#
# Be sure to run `pod lib lint OpenCartKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OpenCartKit"
  s.version          = "0.1.0"
  s.summary          = "an simplicity iOS SDK OpenCartKit use to develop iOS app for ecommerce platform OpenCart"
  s.description      = <<-DESC
                       OpenCartKit can use to develop iOS app for Opencart platform, this is Objective C version
                       DESC
  s.homepage         = "https://github.com/iXCart/OpenCartKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'GNU General Public License version 3 (GPLv3)'
  s.author           = { "RobinCheung" => "iRobinCheung@hotmail.com" }
  s.source           = { :git => "https://github.com/iXCart/OpenCartKit.git", :tag => s.version.to_s }
 
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'OpenCartKit/**/*','Vendor/**/*'
 

  s.public_header_files = 'OpenCartKit/*.h','OpenCartKit/**/*.h'

  s.dependency 'AFNetworking', '~> 2.5.4'
   
   
  s.subspec 'Vendor' do |vendor|
    vendor.ios.deployment_target = '7.0'
 
    vendor.ios.public_header_files = 'Vendor/*.h','Vendor/**/*.h','Vendor/**/**/*.h'
    vendor.ios.source_files = 'Vendor/**/*'
     
  end
  
end
