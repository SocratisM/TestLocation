//
//  ApplicationCoordinator.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

fileprivate var onboardingWasShown = false // Always display onboarding for now

fileprivate enum LaunchInstructor {
	case main, onboarding
	
	static func configure(
		tutorialWasShown: Bool = onboardingWasShown) -> LaunchInstructor {
		
		switch (tutorialWasShown) {
		case false: return .onboarding
		case true: return .main
		}
	}
}

final class ApplicationCoordinator: BaseCoordinator {
	
	private let coordinatorFactory: CoordinatorFactory
	private let router: Router
	
	private var instructor: LaunchInstructor {
		return LaunchInstructor.configure()
	}
	
	init(router: Router, coordinatorFactory: CoordinatorFactory) {
		self.router = router
		self.coordinatorFactory = coordinatorFactory
	}
	
	override func start() {
		switch instructor {
		case .onboarding: runOnboardingFlow()
		case .main: runMainFlow()
		}
	}
	
	private func runOnboardingFlow() {
		let coordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
		coordinator.finishFlow = { [weak self, weak coordinator] in
			onboardingWasShown = true
			self?.start()
			self?.removeDependency(coordinator)
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
	private func runMainFlow() {
		let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator()
		addDependency(coordinator)
		router.setRootModule(module, hideBar: true)
		coordinator.start()
	}
}

