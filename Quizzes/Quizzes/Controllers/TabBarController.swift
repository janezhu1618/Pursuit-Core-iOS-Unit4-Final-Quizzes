//
//  TabBarController.swift
//  Quizzes
//
//  Created by Jane Zhu on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quiz-icon"), tag: 0)
        let searchQuizzesViewController = SearchQuizzesViewController()
        searchQuizzesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let createViewController = CreateViewController()
        createViewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(named: "create-icon"), tag: 2)
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-unfilled"), tag: 3)
        let tabBarList = [quizViewController, searchQuizzesViewController, createViewController, profileViewController]
        viewControllers = tabBarList
    }
    

    

}
