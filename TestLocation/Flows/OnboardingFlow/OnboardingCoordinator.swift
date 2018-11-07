//
//  OnboardingCoordinator.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {

  var finishFlow: (() -> Void)?
  
  private let factory: OnboardingModuleFactory
  private let router: Router
  
  init(with factory: OnboardingModuleFactory, router: Router) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showOnboarding()
  }
}

//MARK: - Run current flow's controllers
private extension OnboardingCoordinator {
	private func showOnboarding() {
		let onboardingModule = factory.makeOnboardingModule()
		onboardingModule.onFinish = { [weak self] in
			self?.finishFlow?()
		}
		router.setRootModule(onboardingModule.toPresent())
	}
}
