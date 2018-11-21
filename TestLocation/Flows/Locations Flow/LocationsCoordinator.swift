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
      self?.runAddLocationFlow(with: locationsOutput)
    }
    router.setRootModule(locationsOutput)
  }
  
  private func openLocationInWiki(_ location: Location) {
    let locationBaseUrlStr = LocationURL.scheme
      + "://"
      + LocationURL.host
    
    var queryItems = [URLQueryItem]()
    // Check for available coordinates
    if let latitude = location.latitude, let longitude = location.longitude {
      queryItems = [URLQueryItem(name: LocationURL.latitude, value: latitude), URLQueryItem(name: LocationURL.longitude, value: longitude)]
    } else {
      // Pass just the place
      queryItems = [URLQueryItem(name: LocationURL.place, value: location.place)]
    }
    
    guard var urlComps = URLComponents(string: locationBaseUrlStr) else {
      debugPrint("Invalid location base url")
      return
    }
    
    urlComps.queryItems = queryItems
    
    guard let locationUrl = urlComps.url else {
      debugPrint("Invalid location final url")
      return
    }
    
    if router.canOpenURL(url: locationUrl) {
      router.openURL(url: locationUrl, completion: nil)
    } else {
      router.present(error: CustomError.missingWikiURLScheme)
    }
  }
  
  private func runAddLocationFlow(with parent: LocationsListView) {
    let (coordinator, module) = coordinatorFactory.makeAddLocationCoordinatorBox()
    coordinator.finishFlow = { [weak self, weak coordinator] location in
      self?.router.dismissModule()
      self?.removeDependency(coordinator)
      if let location = location {
        parent.onNewLocationAdded(location: location)
      }
    }
    addDependency(coordinator)
    router.present(module)
    coordinator.start()
  }
}
