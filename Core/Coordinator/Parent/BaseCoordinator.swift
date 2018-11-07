//
//  BaseCoordinator.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

open class BaseCoordinator: Coordinator {
	
	open var childCoordinators: [Coordinator] = []
	
	public init() {}
	
	open func start() {	}

	open func addDependency(_ coordinator: Coordinator) {
		for element in childCoordinators {
			if element === coordinator { return }
		}
		childCoordinators.append(coordinator)
	}
	
	open func removeDependency(_ coordinator: Coordinator?) {
		guard
			childCoordinators.isEmpty == false,
			let coordinator = coordinator
			else { return }
		
		for (index, element) in childCoordinators.enumerated() {
			if element === coordinator {
				childCoordinators.remove(at: index)
				break
			}
		}
	}
}
