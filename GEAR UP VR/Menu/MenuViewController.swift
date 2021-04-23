//
//  MenuViewController.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 22/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource {
    var menus: [MenuElement]
    let cellReuseIdentifier = "MenuTableViewCell"
    var moreTableView: UITableView = UITableView()
    var moreLIstavigationController: UINavigationController?
    public var changeOrientation: Bool? = false

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (changeOrientation == true) ? .landscape : .portrait
    }

    init(menus: [MenuElement]) {
        self.menus = menus
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var menuItems: [UIViewController]?

        menuItems = Array()

        tabBar.backgroundColor = UIColor.tabBarBgColor
        if menus.count > 0 {
            for index in 0 ... 2 {
                let menuElement = menus[index] as MenuElement
                menuItems?.append(initializeMenuItem(menuElement: menuElement))
            }

            customizeMoreTableView()

            if let viewController = moreNavigationController.topViewController {
                moreLIstavigationController = UINavigationController(rootViewController: viewController)
                viewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.more, tag: 0)

                if let navigationController = moreLIstavigationController {
                    menuItems?.append(navigationController)
                }
            }
            viewControllers = menuItems
        }

        customizableViewControllers = Array()

        applyTheme()
    }

    func applyTheme() {
        tabBar.tintColor = UIColor.tabBarTintSelectedColor
        moreTableView.backgroundColor = UIColor.menuViewControllerBgColor
    }

    /// This method is to stylize more table view as per the design
    func customizeMoreTableView() {
        moreTableView = moreNavigationController.topViewController!.view as? UITableView ?? UITableView()
        moreTableView.delegate = self
        moreTableView.dataSource = self
        moreTableView.rowHeight = 70.0

        moreTableView.backgroundView = nil

        moreTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        let cell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        moreTableView.register(cell, forCellReuseIdentifier: cellReuseIdentifier)
    }

    /// This method is to setup a  screen associated with a particular menu element
    /// which is about to be positioned in the tab bar
    /// - Parameter menuElement: Menu element to tag with the screen
    func initializeMenuItem(menuElement: MenuElement) -> UIViewController {
        let viewController = initializeViewController(menuElement: menuElement)

        let navigationController = UINavigationController(rootViewController: viewController)

        if menuElement.iconLocalFilePath != nil {
            viewController.tabBarItem = UITabBarItem(title: menuElement.title,
                                                     image: UIImage(contentsOfFile: menuElement.iconLocalFilePath ?? ""),
                                                     tag: menuElement.order)

        } else {
            viewController.tabBarItem = UITabBarItem(title: menuElement.title,
                                                     image: UIImage.menuMoreItemDefaultImage,
                                                     tag: menuElement.order)
        }

        viewController.title = menuElement.title

        //			let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        //			navigationController.navigationBar.titleTextAttributes = textAttributes

        //			let img = UIImage()
        //			navigationController.navigationBar.shadowImage = img
        //			navigationController.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)

        return navigationController
    }

    /// Initialize ViewController based on menu element
    /// - Parameter menuElement: corressponding menu element
    func initializeViewController(menuElement: MenuElement) -> UIViewController {
        switch menuElement.keyName {
        case "HOME":
            return HomeViewController()
        case "NC_COLLEGES":
            return NCCollegesViewController()
        case "CAREERS":
            return CareersViewController()
        case "DISABILITY_ACCESS":
            return DisabilityAccessViewController()
        default:
            if menuElement.urlType == PageType.custom || menuElement.urlType == PageType.external {
                return ContentDetailViewController(menuElement: menuElement)
            }
            return ComingSoonViewController()
        }
    }

    // MARK: Tableview Datasource methods

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        let menuCount = menus.count

        if menuCount > 3 {
            return menuCount - 3
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                    for: indexPath) as? MenuTableViewCell {
            let menuElement = menus[indexPath.row + 3]

            cell.title.text = menuElement.title
            cell.title.textColor = UIColor.menuViewControllerCellTextTintColor
            if menuElement.iconLocalFilePath != nil, menuElement.icon != nil {
                cell.imageView?.tintColor = UIColor.menuViewControllerCellImageTintColor
                cell.imageView?.image = UIImage(contentsOfFile: menuElement.iconLocalFilePath!)?
                    .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            } else {
                cell.imageView?.image = UIImage.menuMoreItemDefaultImage
            }

            cell.selectionStyle = .none

            return cell
        }
        return UITableViewCell()
    }

    // MARK: Tableview Delegate methods

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        var screen: UIViewController?

        let menuElement = menus[indexPath.row + 3]

        screen = initializeViewController(menuElement: menuElement)
        screen?.title = menuElement.title
        if let thisScreen = screen {
            if let navigationController = moreLIstavigationController {
                navigationController.pushViewController(thisScreen, animated: true)
            }
        } else {
            showStandardAlert(message: ErrorMessages.errorToLoadScreen)
        }
    }

    override func traitCollectionDidChange(_: UITraitCollection?) {
        applyTheme()
        moreTableView.reloadData()
    }
}
