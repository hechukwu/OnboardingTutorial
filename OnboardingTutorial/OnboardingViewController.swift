import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    weak var onBoardingPageViewController: OnboardingPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func skipButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onBoardingViewController = segue.destination as? OnboardingPageViewController {
            onBoardingViewController.pageViewControllerDelagate = self
            onBoardingPageViewController = onBoardingViewController
        }
    }
}

extension OnboardingViewController: onboardingPageViewControllerDelegate {

    func setupPageController(numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }

    func turnPageController(to index: Int) {
        pageControl.currentPage = index
    }
}
