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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setShow(show: Show) {
        self.show = show
        print(show)
    }

}
