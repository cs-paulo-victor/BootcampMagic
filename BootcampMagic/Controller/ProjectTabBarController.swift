//
//  ProjectNavigationController.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 17/03/21.
//

import UIKit

class ProjectTabBarController: UITabBarController {
    let projectTabBarController = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        assignBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func assignBackground() {
        let background = UIImage(named: "fundo")

        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
      }

    func setupTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: TextFont.button], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: TextFont.button], for: .selected)

        UITabBar.appearance().tintColor = TextColor.button
        UITabBar.setTransparentTabbar()
        viewControllers = [setupExpansionsViewController(), setupFavoritesViewController()]
    }

    func setupExpansionsViewController() -> UINavigationController {
        let firstViewController = UINavigationController(rootViewController: ExpansionsViewController())
        firstViewController.title = "Expansions"
        return firstViewController
    }

    func setupFavoritesViewController() -> UINavigationController {
        let secondViewController = UINavigationController(rootViewController: FavoritesViewController())
        secondViewController.title = "Favorites"
        return secondViewController
    }
}

extension UITabBar {
    static func setTransparentTabbar() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
}
