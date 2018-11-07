//
//  CoordinatorFactoryConcrete.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

final class CoordinatorFactoryConcrete: CoordinatorFactory {
	
	func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
		let controller = TabbarController.controllerFromStoryboard(.main)
		let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryConcrete())
		return (coordinator, controller)
	}
	
	func makeLocationsCoordinator() -> Coordinator {
		return makeLocationsCoordinator(navController: nil)
	}
	
	func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput {
		return OnboardingCoordinator(with: ModuleFactoryConcrete(), router: router)
	}
	
	func makeLocationsCoordinator(navController: UINavigationController?) -> Coordinator {
		let coordinator = LocationsCoordinator(
			router: router(navController),
			factory: ModuleFactoryConcrete(),
			coordinatorFactory: CoordinatorFactoryConcrete()
		)
		return coordinator
	}
	
	func makeAddLocationCoordinatorBox() ->
		(configurator: Coordinator & AddLocationCoordinatorOutput,
		toPresent: Presentable?) {
			return makeAddLocationCoordinatorBox(navController: navigationController(nil))
	}
	
	func makeAddLocationCoordinatorBox(navController: UINavigationController?) ->
		(configurator: Coordinator & AddLocationCoordinatorOutput,
		toPresent: Presentable?) {
			
			let router = self.router(navController)
			let coordinator = AddLocationCoordinator(router: router, factory: ModuleFactoryConcrete())
			return (coordinator, router)
	}
}

fileprivate extension CoordinatorFactory {
	fileprivate func router(_ navController: UINavigationController?) -> Router {
		return RouterConcrete(rootController: navigationController(navController))
	}
	
	fileprivate func navigationController(_ navController: UINavigationController?) -> UINavigationController {
		if let navController = navController { return navController }
		else { return UINavigationController.controllerFromStoryboard(.main) }
	}
}
