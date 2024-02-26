//
//  MainCoordinator.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 24.11.2023.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func initialViewController()
    func createMainModule() -> UIViewController
}

final class Coordinator: MainCoordinatorProtocol {
    
    private var navCon: UINavigationController?
    
    init(navCon: UINavigationController) {
        self.navCon = navCon
    }
    
    //MARK: - initialViewController
    func initialViewController() {
        if let navCon = navCon {
            let view = createMainModule()
            
            navCon.viewControllers = [view]
        }
    }
    
    //MARK: - createMainModule
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        let coordinator = self
        
        view.viewModel = viewModel
        viewModel.coordinator = coordinator
        
        return view
    }
    
    
}
