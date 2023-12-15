# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# Comment the next line if you don't want to use dynamic frameworks
install! 'cocoapods', :deterministic_uuids => false
inhibit_all_warnings!
use_frameworks!

def platform_pods
end

def domain_pods
end

def app_pods
  pod 'RXVIPArchitechture', path: '../RXVIPArchitechture'
  pod 'RealmSwift'
  pod 'SteviaLayout'
  pod 'Domain', path: "../Domain"
  pod 'Platform', path: "../Platform"
end

target 'RX_Base_VIP' do
  app_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
      target.build_configurations.each do |config|
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
    
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
  
  installer.pods_project.targets.each do |target|
    if target.name == ‘RxSwift’
      target.build_configurations.each do |config|
        if config.name == ‘Debug’
          config.build_settings[‘OTHER_SWIFT_FLAGS’] ||= [‘-D’, ‘TRACE_RESOURCES’]
        end
      end
    end
  end
  
end
