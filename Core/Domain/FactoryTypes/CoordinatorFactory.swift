//
//  CoordinatorFactory.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public protocol CoordinatorFactory {
	
	func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
	
  func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
  
  func makeLocationsCoordinator(navController: UINavigationController?) -> Coordinator
  func makeLocationsCoordinator() -> Coordinator
	
	func makeAddLocationCoordinatorBox() ->
    (configurator: Coordinator & AddLocationCoordinatorOutput,
    toPresent: Presentable?)
  
  func makeAddLocationCoordinatorBox(navController: UINavigationController?) ->
    (configurator: Coordinator & AddLocationCoordinatorOutput,
    toPresent: Presentable?)
}
