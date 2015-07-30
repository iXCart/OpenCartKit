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
  s.version          = "0.1.1"
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

#   s.source_files = 'OpenCartKit/**/*','Vendor/**/*'
#    s.public_header_files = 'OpenCartKit/*.h','OpenCartKit/**/*.h'

    s.dependency 'AFNetworking', '~> 2.5.4'
   
    s.public_header_files = 'OpenCartKit/*.h','OpenCartKit/*.pch'
    s.source_files = 'OpenCartKit/OpenCartKit.h','OpenCartKit/*.pch'

    s.subspec 'Services' do |ss|
#        ss.source_files = 'OpenCartKit/Services/**/*.{h,m}'
#        ss.ios.public_header_files = 'OpenCartKit/Services/**/*.h'
        
        ss.subspec 'Core' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Core/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Core/*'
        end
  		ss.subspec 'Exception' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Exception/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Exception/*'
        end
        ss.subspec 'Product' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Catalog/Product/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Catalog/Product/*'
        end
        ss.subspec 'Account' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Catalog/Account/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Catalog/Account/*'
        end
        ss.subspec 'Checkout' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Catalog/Checkout/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Catalog/Checkout/*'
        end
        ss.subspec 'Payment' do |c|
            c.ios.public_header_files = 'OpenCartKit/Services/Catalog/Payment/*.h'
            c.ios.source_files = 'OpenCartKit/Services/Catalog/Payment/*'
        end

    end

    s.subspec 'Support' do |ss|
        ss.source_files = 'OpenCartKit/Support/*.{h,m}'
        ss.ios.public_header_files = 'OpenCartKit/Support/*.h'

    end

    s.subspec 'Vendor' do |v|
         v.subspec 'Foundation' do |f|
                f.ios.public_header_files = 'Vendor/Foundation/*.h','Vendor/Foundation/**/*.h'
                f.ios.source_files = 'Vendor/Foundation/*','Vendor/Foundation/**/*'
         end
        v.subspec 'Security' do |s|
            s.ios.public_header_files = 'Vendor/Security/*.h','Vendor/Security/**/*.h'
            s.ios.source_files = 'Vendor/Security/**/*'
        end

#        vendor.ios.public_header_files = 'Vendor/*.h','Vendor/**/*.h','Vendor/**/**/*.h'
#        vendor.ios.source_files = 'Vendor/**/*'
    end
  
end
