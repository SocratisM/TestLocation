//
//  OnboardingController.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import UIKit
import Core

class OnboardingController: UIViewController, OnboardingView {
	
	//MARK: - Controller handlers
  var onFinish: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
		self.title = "Intro"
  }
  
  @IBAction func finishTapped(_ sender: Any) {
    onFinish?()
  }
}
