# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!

def core_pods
    #Keyboard Management
    pod 'IQKeyboardManagerSwift'

    #Realm
    pod 'RealmSwift'
end

def ui_pods
    #Toast alert
    pod 'Toast-Swift'    
end

def rx_pods    
    # Rx
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxGesture'
end
 

target 'Demo' do
    core_pods
    ui_pods
    rx_pods
end
