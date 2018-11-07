//
//  LocationsCoordinator.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

final class LocationsCoordinator: BaseCoordinator {
	
	private let factory: LocationsModuleFactory
	private let coordinatorFactory: CoordinatorFactory
	private let router: Router
	
	init(router: Router, factory: LocationsModuleFactory, coordinatorFactory: CoordinatorFactory) {
		self.router = router
		self.factory = factory
		self.coordinatorFactory = coordinatorFactory
	}
	
	override func start() {
		showLocationsList()
	}
}

//MARK: - Run current flow's controllers
private extension LocationsCoordinator {
	private func showLocationsList() {
		
		let locationsOutput = factory.makeLocationsOutput()
		locationsOutput.onLocationSelect = { [weak self] location in
			self?.openLocationInWiki(location)
		}
		
		locationsOutput.onAddLocation = { [weak self] in
			// TODO
		}
		router.setRootModule(locationsOutput)
	}
	
	private func openLocationInWiki(_ location: Location) {
			// TODO
	}
	
	private func runAddLocationFlow() {
		let (coordinator, module) = coordinatorFactory.makeAddLocationCoordinatorBox()
		coordinator.finishFlow = { [weak self, weak coordinator] location in
			//TODO
		}
		addDependency(coordinator)
		router.present(module)
		coordinator.start()
	}
}
