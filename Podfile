# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

target 'Recody' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint'
  pod 'DropDown'
  pod 'Charts'
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'IQKeyboardManagerSwift'
  # Pods for Recody

end
