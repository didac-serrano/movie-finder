//
//  BaseWireframeProtocol.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation
import UIKit

protocol BaseWireframeProtocol: class {
    
    func present(viewController: UIViewController?, fromViewController: UIViewController?, animated: Bool)
    func dismiss(viewController: UIViewController?, animated: Bool, completion: (() -> Void)?)
    func pop(viewController: UIViewController?)
    func popToRoot(viewController: UIViewController?)
    func push(viewController: UIViewController?, fromViewController: UIViewController?)
}

extension BaseWireframeProtocol {
    
    func present(viewController: UIViewController?, fromViewController: UIViewController?) {
        present(viewController: viewController, fromViewController: fromViewController, animated: true)
    }
    
    func dismiss(viewController: UIViewController?, completion: (() -> Void)? = nil) {
        dismiss(viewController: viewController, animated: true, completion: completion)
    }
}

enum BaseWireframeAction {
    
    case present(viewController: UIViewController?, fromViewController: UIViewController?, animated: Bool)
    case dismiss(viewController: UIViewController?, animated: Bool, completion: (() -> Void)?)
    case pop(viewController: UIViewController?)
    case popToRoot(viewController: UIViewController?)
    case push(viewController: UIViewController?, fromViewController: UIViewController?)
}

protocol BaseWireframeExecutorProtocol {
    
    func execute(_ action: BaseWireframeAction)
}

class BaseWireframeExecutor: BaseWireframeExecutorProtocol {
    
    func execute(_ action: BaseWireframeAction) {
        ViewDispatcher.shared.execute {
            switch action {
            case .present(let viewController, let fromViewController, let animated):
                guard let viewController = viewController, let fromViewController = fromViewController else { return }
                fromViewController.present(viewController, animated: animated, completion: nil)
            case .dismiss(let viewController, let animated, let completion):
                guard let viewController = viewController else { return }
                viewController.dismiss(animated: animated, completion: completion)
            case .pop(let viewController):
                guard let viewController = viewController else { return }
                _ = viewController.navigationController?.popViewController(animated: true)
            case .popToRoot(let viewController):
                guard let viewController = viewController else { return }
                viewController.navigationController?.popToRootViewController(animated: true)
            case .push(let viewController, let fromViewController):
                guard let viewController = viewController, let fromViewController = fromViewController else { return }
                fromViewController.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

class BaseWireFrame: NSObject {
    
    private var executor: BaseWireframeExecutorProtocol
    
    init(executor: BaseWireframeExecutorProtocol = BaseWireframeExecutor()) {
        self.executor = executor
        super.init()
    }
    
    func present(viewController: UIViewController?, fromViewController: UIViewController?, animated: Bool = true) {
        executor.execute(.present(viewController: viewController, fromViewController: fromViewController, animated: animated))
    }
    
    func dismiss(viewController: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        executor.execute(.dismiss(viewController: viewController, animated: animated, completion: completion))
    }
    
    func pop(viewController: UIViewController?) {
        executor.execute(.pop(viewController: viewController))
    }
    
    func popToRoot(viewController: UIViewController?) {
        executor.execute(.popToRoot(viewController: viewController))
    }
    
    func push(viewController: UIViewController?, fromViewController: UIViewController?) {
        executor.execute(.push(viewController: viewController, fromViewController: fromViewController))
    }
}

