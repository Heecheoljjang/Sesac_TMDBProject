//
//  PageViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/16.
//

import UIKit

class PageViewController: UIPageViewController {

    var viewControllerList: [UIViewController] = []
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        createViewControllerList()
        
        configurePageViewController()
    }

    func createViewControllerList() {
        let sb = UIStoryboard(name: "PageView", bundle: nil)
        guard let firstVC = sb.instantiateViewController(withIdentifier: FirstViewController.identifier) as? FirstViewController, let secondVC = sb.instantiateViewController(withIdentifier: SecondViewController.identifier) as? SecondViewController, let thirdVC = sb.instantiateViewController(withIdentifier: ThirdViewController.identifier) as? ThirdViewController, let fourthVC = sb.instantiateViewController(withIdentifier: FourthViewController.identifier) as? FourthViewController else { return }
        
        viewControllerList = [firstVC, secondVC, thirdVC, fourthVC]
    }
    
    func configurePageViewController() {
        
        delegate = self
        dataSource = self
        
        //display
        guard let first = viewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= viewControllerList.count ? nil : viewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = viewControllerList.firstIndex(of: first) else { return 0 }
        
        print(index)
        
        return index
    }
    
}
