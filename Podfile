platform :ios, '10.0'

use_frameworks!

def reactive
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'Core' do

  reactive

  target 'CoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'TestLocation' do
  reactive

  target 'TestLocationTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
