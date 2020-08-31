//
//  MainTabVC.swift
//  InstaGramClone
//
//  Created by MANINDER SINGH on 12/08/20.
//  Copyright © 2020 MANINDER SINGH. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        configureViewController()
        checkUserLoggedIn()

        // Do any additional setup after loading the view.
    }
    
    func configureViewController(){
        //home feed controller
        let feedVcs = configureNavController(unSelectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"),rootViewController: feedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        //search controller
        let searchVC = configureNavController(unSelectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        // post
        let postVC =  configureNavController(unSelectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UploadPostVC())
        //notification
        let notificationVC = configureNavController(unSelectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        //profile
        let userProfileVC = configureNavController(unSelectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        viewControllers=[feedVcs,searchVC,postVC,notificationVC,userProfileVC]
        tabBar.tintColor = .black
    }
    
    func configureNavController(unSelectedImage:UIImage,selectedImage:UIImage,rootViewController:UIViewController=UIViewController())->UINavigationController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image=unSelectedImage
        navController.tabBarItem.selectedImage=selectedImage
        navController.navigationBar.tintColor = .black
        return navController
    }
    func checkUserLoggedIn(){
        if Auth.auth().currentUser==nil{
            print("no current user ")
            DispatchQueue.main.async {
                let navigationController = UINavigationController(rootViewController: LoginVC())
                 navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }
    }
}
