//
//  MainUITaViewController.swift
//  CaseVersion1
//
//  Created by Hasan onur Can on 9.03.2022.
//

import UIKit

class MainUITaViewController: UITabBarController {
    
    var products = [Product]()
    var enter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FOR Dummy Login
        if enter == 0 {
            enter += 1
            DispatchQueue.main.async {
                let loginViewController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        designPage()
    }
    
    func designPage() {
        let araNavController = navControllerOlustur(seciliOlmayanIkon: #imageLiteral(resourceName: "Ana_Ekran_Secili_Degil"), seciliIkon: #imageLiteral(resourceName: "Ana_Ekran_Secili"),rootViewController: ProductViewController())
        
        let ekleNavController = navControllerOlustur(seciliOlmayanIkon: #imageLiteral(resourceName: "Begeni_Secili_Degil"), seciliIkon: #imageLiteral(resourceName: "Begeni_Secili"))
        
        let begeniNavController = navControllerOlustur(seciliOlmayanIkon: #imageLiteral(resourceName: "Profil"), seciliIkon: #imageLiteral(resourceName: "Profil_Secili"))
        
        viewControllers = [araNavController, ekleNavController,begeniNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    func navControllerOlustur(seciliOlmayanIkon : UIImage, seciliIkon : UIImage, rootViewController : UIViewController = UIViewController()) -> UINavigationController {
        let rootController = rootViewController
        let navController = UINavigationController(rootViewController: rootController)
        navController.tabBarItem.image = seciliOlmayanIkon
        navController.tabBarItem.selectedImage = seciliIkon
        return navController
    }
}







