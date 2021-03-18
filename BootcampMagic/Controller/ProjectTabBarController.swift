//
//  ProjectNavigationController.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 17/03/21.
//

import UIKit

class ProjectTabBarController: UITabBarController {
    let projectTBC = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        creatTabBarController()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }

    func creatTabBarController() {
        let firstViewController = UINavigationController(rootViewController: ExpansionsViewController())
        let secondViewController = UINavigationController(rootViewController: FavoritesViewController())

        firstViewController.title = "Expansions"
        secondViewController.title = "Favorites"

        projectTBC.setViewControllers([firstViewController, secondViewController], animated: true)
        self.view.addSubview(projectTBC.view)
    }

}
