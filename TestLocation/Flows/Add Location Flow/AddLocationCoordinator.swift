//
//  AddLocationCoordinator.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

final class AddLocationCoordinator: BaseCoordinator, AddLocationCoordinatorOutput {
  
  var finishFlow: ((Location?)->())?
  
  private let factory: AddLocationModuleFactory
  private let router: Router
  
  init(router: Router, factory: AddLocationModuleFactory) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showAddLocation()
  }
}

//MARK: - Run current flow's controllers
private extension AddLocationCoordinator {
	private func showAddLocation() {
		let addLocationOutput = factory.makeAddLocationOutput()
		addLocationOutput.onCompleteAddLocation = { [weak self] location in
			self?.finishFlow?(location)
		}
		addLocationOutput.onHideButtonTap = { [weak self] in
			self?.finishFlow?(nil)
		}
		router.setRootModule(addLocationOutput)
	}
}
