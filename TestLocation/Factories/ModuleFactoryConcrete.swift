//
//  ModuleFactoryConcrete.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

final class ModuleFactoryConcrete:
  OnboardingModuleFactory,
  LocationsModuleFactory,
  AddLocationModuleFactory {
	
  func makeOnboardingModule() -> OnboardingView {
    return OnboardingController.controllerFromStoryboard(.onboarding)
  }
	
  func makeLocationsOutput() -> LocationsListView {
    return LocationsListController.controllerFromStoryboard(.locationsList)
  }
	
  func makeAddLocationOutput() -> AddLocationView {
    return AddLocationController.controllerFromStoryboard(.addLocation)
  }
}
