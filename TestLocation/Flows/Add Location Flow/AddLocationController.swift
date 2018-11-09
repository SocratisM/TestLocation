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
import RxSwift
import RxCocoa

final class AddLocationController: UIViewController, AddLocationView {
  
  //MARK: - Outlets
  @IBOutlet weak var placeTextField: UITextField!
  @IBOutlet weak var latitudeTextField: UITextField!
  @IBOutlet weak var longitudeTextField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var doneButton: UIButton!
  
  //MARK: - Controller handlers
  var onHideButtonTap: (() -> Void)?
  var onCompleteAddLocation: ((Location) -> ())?
  
  // MARK: - Properties
  var viewModel: AddLocationViewModel!
  let bag = DisposeBag()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = NSLocalizedString("add_location_title", comment: "")
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(AddLocationController.hideButtonClicked(_:)))
    
    setupBindings()
  }
  
  // MARK: - Setup
  private func setupBindings() {
    viewModel.bind(done: doneButton.rx.tap.asObservable(), source: self)
    placeTextField.rx.text <-> viewModel.place >>> bag
    longitudeTextField.rx.text <-> viewModel.longitude >>> bag
    latitudeTextField.rx.text <-> viewModel.latitude >>> bag
    
    viewModel.error.drive(errorLabel.rx.text) >>> bag
    viewModel.errorVisible.map({ !$0 }).drive(errorLabel.rx.isHidden) >>> bag
    
    viewModel.didFinish.drive(onNext: { [weak self] location in
      self?.onCompleteAddLocation?(location)
    }) >>> bag
  }
  
  // MARK: - Action
  @IBAction func hideButtonClicked(_ sender: UIBarButtonItem) {
    onHideButtonTap?()
  }
  
  @IBAction func dismissKeyboard(_ sender: Any?) {
    self.view.endEditing(true)
  }
}
