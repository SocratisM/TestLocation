//
//  AddLocationView.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public protocol AddLocationView: BaseView {
  var viewModel: AddLocationViewModel! { get set }
  var onHideButtonTap: (() -> Void)? { get set }
  var onCompleteAddLocation: ((Location) -> ())? { get set }
}
