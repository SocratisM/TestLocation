//
//  RouterConcrete.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

final public class RouterConcrete: NSObject, Router {
	
  private weak var rootController: UINavigationController?
  private var completions: [UIViewController : () -> Void]
  
  public init(rootController: UINavigationController) {
    self.rootController = rootController
    completions = [:]
  }
  
  public func toPresent() -> UIViewController? {
    return rootController
  }
  
  public func present(_ module: Presentable?) {
    present(module, animated: true)
  }
  
  public func present(_ module: Presentable?, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    rootController?.present(controller, animated: animated, completion: nil)
  }
  
  public func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }
  
  public func dismissModule(animated: Bool, completion: (() -> Void)?) {
    rootController?.dismiss(animated: animated, completion: completion)
  }
  
  public func push(_ module: Presentable?)  {
    push(module, animated: true)
  }
  
  public func push(_ module: Presentable?, animated: Bool)  {
    push(module, animated: animated, completion: nil)
  }
  
  public func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
    guard
      let controller = module?.toPresent(),
      (controller is UINavigationController == false)
      else { assertionFailure("Deprecated push UINavigationController."); return }
    
    if let completion = completion {
      completions[controller] = completion
    }
    rootController?.pushViewController(controller, animated: animated)
  }
  
  public func popModule()  {
    popModule(animated: true)
  }
  
  public func popModule(animated: Bool)  {
    if let controller = rootController?.popViewController(animated: animated) {
      runCompletion(for: controller)
    }
  }
  
  public func setRootModule(_ module: Presentable?) {
    setRootModule(module, hideBar: false)
  }
  
  public func setRootModule(_ module: Presentable?, hideBar: Bool) {
    guard let controller = module?.toPresent() else { return }
    rootController?.setViewControllers([controller], animated: false)
    rootController?.isNavigationBarHidden = hideBar
  }
	
  public func present(error: CustomError) {
    let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }
	
  public func popToRootModule(animated: Bool) {
    if let controllers = rootController?.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        runCompletion(for: controller)
      }
    }
  }
  
  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
	
	public func canOpenURL(url: URL) -> Bool {
		return UIApplication.shared.canOpenURL(url)
	}
	
	public func openURL(url: URL, completion: ((Bool) -> ())? = nil) {
		UIApplication.shared.open(url, options: [:], completionHandler: completion)
	}
}
