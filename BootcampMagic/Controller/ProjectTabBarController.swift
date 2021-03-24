//
//  ProjectNavigationController.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 17/03/21.
//

import UIKit

class ProjectTabBarController: UITabBarController {

    let projectTabBarController = UITabBarController()
    var cleanDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        creatBorderTabBar()
        setupTabBar()
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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key
                                                            .font: TextFont.button ?? .systemFont(ofSize: 16)],
                                                         for: .normal)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key
                                                            .font: TextFont.button ?? .systemFont(ofSize: 16)],
                                                         for: .selected)
        UITabBar.appearance().unselectedItemTintColor = TextColor.buttonTabBarUnselected
        UITabBar.appearance().tintColor = TextColor.buttonTabBarSelect
        UITabBar.appearance().backgroundColor = .white
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        viewControllers = [setupExpansionsViewController()]
    }

    func setupExpansionsViewController() -> UINavigationController {
        let firstViewController = UINavigationController(rootViewController: ExpansionsViewController())
        firstViewController.title = "Expansions"
        return firstViewController
    }

    func creatBorderTabBar() {
        let topline = CALayer()
        topline.frame = CGRect(x: 24, y: 0, width: self.tabBar.frame.width - 48, height: 2)
        topline.backgroundColor = UIColor.black.cgColor
        self.tabBar.layer.addSublayer(topline)
    }
}
