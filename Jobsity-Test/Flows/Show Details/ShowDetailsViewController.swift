//
//  ShowDetailsViewController.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit

class ShowDetailsViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    private var show: Show?
    private var presenter: ShowDetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ShowDetailsPresenter(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let show = show else { return }
        presenter?.fetchEpisodes(showId: show.id)
    }
    
    // MARK: - Functions
    func setShow(show: Show) {
        self.show = show
    }

}

extension ShowDetailsViewController: ShowDetailsPresenterDelegate {
    func showDetailsPresenterDelegate(fetched episodes: [Episode]) {
        //
    }
}
