//
//  ShowsListPresenter.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import Foundation
import UIKit

protocol ShowsListPresenterDelegate: AnyObject {
    func showsListPresenterDelegate(fetched shows: [Show])
}

class ShowsListPresenter {
    
    let view: (UIViewController & ShowsListPresenterDelegate)?
    
    init(view: (UIViewController & ShowsListPresenterDelegate)) {
        self.view = view
    }
    
    func fetchSeries() {
        self.view?.presentLoadingScreen {
            WebService.get(path: "https://api.tvmaze.com/shows?page=0", type: [Show].self) {[weak self] result in
                guard let self = self else {
                    self?.view?.dismiss(animated: true, completion: nil)
                    return
                }
                DispatchQueue.main.async {
                    self.view?.dismiss(animated: true, completion: nil)
                    switch result {
                    case .success(let shows):
                        self.view?.showsListPresenterDelegate(fetched: shows)
                    case .failure(_):
                        self.view?.presentAlert(message: "Something went wrong")
                    }
                }
            }
        }
    }
    
}
