//
//  MainCoordinator.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: CoordinatorEvent) {
        switch type {
        case .goToDetails:
            break
        }
    }
    
    func start() {
        let vc: ShowsListViewController & Coordinating = ShowsListViewController.instantiate()
        vc.coordinator = self

        navigationController?.setViewControllers([vc], animated: true)
    }
}
