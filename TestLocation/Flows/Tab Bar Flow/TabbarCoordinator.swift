//
//  TabbarCoordinator.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

class TabbarCoordinator: BaseCoordinator {
  
  private let tabbarView: TabbarView
  private let coordinatorFactory: CoordinatorFactory
  
  init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory) {
    self.tabbarView = tabbarView
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    tabbarView.onViewDidLoad = runLocationsFlow()
    tabbarView.onLocationsFlowSelect = runLocationsFlow()
  }
}

//MARK: - Run current flow's controllers
private extension TabbarCoordinator {
	private func runLocationsFlow() -> ((UINavigationController) -> ()) {
		return { [unowned self] navController in
			if navController.viewControllers.isEmpty == true {
				let locationCoordinator = self.coordinatorFactory.makeLocationsCoordinator(navController: navController)
				self.addDependency(locationCoordinator)
				locationCoordinator.start()
			}
		}
	}
}


