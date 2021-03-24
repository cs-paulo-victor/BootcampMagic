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
        creatBorderTabBar()
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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key
                                                            .font: TextFont.button ?? .systemFont(ofSize: 16)],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key
                                                            .font: TextFont.button ?? .systemFont(ofSize: 16)],
                                                         for: .selected)

        UITabBar.appearance().tintColor = TextColor.button
        UITabBar.setTransparentTabbar()
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
        topline.backgroundColor = UIColor.white.cgColor
        self.tabBar.layer.addSublayer(topline)
    }
}

extension UITabBar {
    static func setTransparentTabbar() {
        UITabBar.appearance().backgroundImage = UIImage()
    }
}
