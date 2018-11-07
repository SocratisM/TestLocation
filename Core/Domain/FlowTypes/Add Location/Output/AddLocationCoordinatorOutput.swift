//
//  AddLocationCoordinatorOutput.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public protocol AddLocationCoordinatorOutput: class {
  var finishFlow: ((Location?)->())? { get set }
}
