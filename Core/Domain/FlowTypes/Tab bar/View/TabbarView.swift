//
//  TabbarView.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import UIKit

public protocol TabbarView: class {
  var onLocationsFlowSelect: ((UINavigationController) -> ())? { get set }
  var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
