//
//  AddLocationController.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import UIKit
import Foundation
import Core

final class AddLocationController: UIViewController, AddLocationView {
	
	//MARK: - Controller handlers
  var onHideButtonTap: (() -> Void)?
  var onCompleteAddLocation: ((Location) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Add Location"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(AddLocationController.hideButtonClicked(_:)))
  }
  
  @IBAction func hideButtonClicked(_ sender: UIBarButtonItem) {
    onHideButtonTap?()
  }
}
