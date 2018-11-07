//
//  TabbarController.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import UIKit
import Core

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {

	//MARK: - Controller handlers
	var onLocationsFlowSelect: ((UINavigationController) -> ())?
  var onViewDidLoad: ((UINavigationController) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    if let controller = customizableViewControllers?.first as? UINavigationController {
      onViewDidLoad?(controller)
    }
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    
    if selectedIndex == 0 {
      onLocationsFlowSelect?(controller)
    }
  }
}
