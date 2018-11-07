//
//  AppDelegate.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder {
	
	var window: UIWindow?
	var rootController: UINavigationController {
		return self.window!.rootViewController as! UINavigationController
	}
	
	private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()
}

extension AppDelegate: UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		applicationCoordinator.start()
		return true
	}
}

fileprivate extension AppDelegate {
	fileprivate func makeCoordinator() -> Coordinator {
		return ApplicationCoordinator(
			router: RouterConcrete(rootController: self.rootController),
			coordinatorFactory: CoordinatorFactoryConcrete()
		)
	}
}
