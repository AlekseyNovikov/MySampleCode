link_with 'ITOPK'
#Core data wrapper
pod 'MagicalRecord'
#set URL image
pod 'SDWebImage'
# keychain
pod 'JNKeychain'
#AFNetworking for Navigine
#pod 'AFNetworking'
#PushNotification
pod 'Appboy-iOS-SDK'
#moving text fields out of the way of the keyboard in iOS
pod 'TPKeyboardAvoiding'
#AutocopliteTextField
pod 'MLPAutoCompleteTextField'
#Sandwich menu
pod 'SWRevealViewController'

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited), PodsDummy_Pods=MyPodsDummy_Pods'
        end
    end
end