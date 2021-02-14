import UIKit

protocol onboardingPageViewControllerDelegate: class {
    func setupPageController(numberOfPage: Int)
    func turnPageController(to index: Int)
}

class OnboardingPageViewController: UIPageViewController {

    weak var pageViewControllerDelagate: onboardingPageViewControllerDelegate?

    var pageTitle = ["First Page", "Second Page", "Third Page"]
    var pageImages: [UIImage] = []
    var pageDescriptionText = ["This is first page stating what this app is about", "A second page stating more app info incase you need them", "The very last page with yet more info for our esteem users"]
    var backgroundColor : [UIColor] = [.blue, .green, .red]
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstViewController = contentViewController(at: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index -= 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index += 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let pageContentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
            currentIndex = pageContentViewController.index
            self.pageViewControllerDelagate?.turnPageController(to: currentIndex)
        }
    }
    
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageTitle.count {
            return nil
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: "onboardingContentVC") as? OnboardingContentViewController {
//            pageContentViewController.image = pageImages[index]
            pageContentViewController.subHeading = pageDescriptionText[index]
            pageContentViewController.heading = pageTitle[index]
            pageContentViewController.bgColor = backgroundColor[index]
            pageContentViewController.index = index
            self.pageViewControllerDelagate?.setupPageController(numberOfPage: 3)
            return pageContentViewController
        }
        return nil
    }
}
