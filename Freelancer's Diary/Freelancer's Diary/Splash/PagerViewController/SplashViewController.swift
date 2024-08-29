//
//  SplashViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var splashPageViewController: SplashPageViewController!

    @IBOutlet weak var firstDot: UIButton!
    @IBOutlet weak var secondDot: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    private var currentIndex = -1
    private var pages: [UIViewController] = [FirstSplashViewController(nibName: "FirstSplashViewController", bundle: nil), SecondSplashViewController(nibName: "SecondSplashViewController", bundle: nil)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentPage(index: 0)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desinationViewController = segue.destination as? SplashPageViewController {
            splashPageViewController = desinationViewController
            splashPageViewController.delegate = self
            splashPageViewController.dataSource = self
        }
    }
    
    func pageChangedTo(index: Int) {
        switch index {
        case 0:
            firstDot.backgroundColor = .white.withAlphaComponent(0.5)
            secondDot.backgroundColor = UIColor(named: "ButtonColor")
            nextButton.setTitle("Next", for: .normal)
        case 1:
            secondDot.backgroundColor = .white.withAlphaComponent(0.5)
            firstDot.backgroundColor = UIColor(named: "ButtonColor")
            nextButton.setTitle("Start", for: .normal)
        default:
            break
        }
    }
    
    func setCurrentPage(index: Int) {
        if index == currentIndex { return }
        let direction: UIPageViewController.NavigationDirection = index < currentIndex ? .reverse : .forward
        currentIndex = index
        splashPageViewController.setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
        pageChangedTo(index: index)
    }
    
    @IBAction func chooseFirstPage(_ sender: UIButton) {
        setCurrentPage(index: 0)
    }

    @IBAction func chooseSecondPage(_ sender: UIButton) {
        setCurrentPage(index: 1)
    }

    @IBAction func clickedNext(_ sender: UIButton) {
        if currentIndex == 0 {
            setCurrentPage(index: 1)
        } else {
            UserDefaults.standard.set(true, forKey: .hasLaunchedBeforeKey)
            let homeVC = UIStoryboard(name: "TabBar", bundle: .main).instantiateViewController(withIdentifier: "TabBarController")
            homeVC.setAsRoot()
        }
    }
    
}

extension SplashViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPage = pageViewController.viewControllers?.first {
            let index = pages.firstIndex(of: currentPage)!
            currentIndex = index
            pageChangedTo(index: index)
        }
    }
}

extension SplashViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.pages.firstIndex(of: viewController)!
        if (index == 0) {
            return nil
        } else {
            return self.pages[index - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.pages.firstIndex(of: viewController)!
        if (index == self.pages.count - 1) {
            return nil
        } else {
            return self.pages[index + 1]
        }
    }
}

extension UIViewController {
    func setAsRoot() {
        UIApplication.shared.windows.first?.rootViewController = self
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
