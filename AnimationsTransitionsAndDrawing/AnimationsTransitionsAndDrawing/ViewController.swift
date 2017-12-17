//
//  ViewController.swift
//  AnimationsTransitionsAndDrawing
//
//  Created by Felipe Lefèvre Marino on 12/7/17.
//  Copyright © 2017 Felipe Lefèvre Marino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var donutChart: DonutChart!
    @IBOutlet weak var reviewButton: CustomButton!
    @IBOutlet weak var wonProgressView: CorneredProgressView!
    @IBOutlet weak var lostProgressView: CorneredProgressView!
    @IBOutlet weak var historyView: BorderedUIView!
    @IBOutlet weak var reviewsView: BorderedUIView!
    
    let animationController = CircleAnimatedTransitionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Player Stats"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 94/255, green: 45/255, blue: 121/255, alpha: 1)
        
        reviewButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let image = reviewButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        reviewButton.setImage(image, for: .normal)
        reviewButton.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
        segue.destination.modalPresentationStyle = .custom
    }
}

// MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let content = CGRect(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y, width: scrollView.frame.width, height: scrollView.frame.height)
        
        //verifiy if the frame of the progressViews in relation to scrollView space intersects with its offset
        if content.contains(scrollView.convert(wonProgressView.frame, from: historyView)) {
            wonProgressView.animate(toProgress: 0.85)
        }
        if content.contains(scrollView.convert(lostProgressView.frame, from: historyView)) {
            lostProgressView.animate(toProgress: 0.15)
        }
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationController.transitionMode = .dismiss
        animationController.startingPoint = view.convert(reviewButton.center, from: reviewsView)
        animationController.circleColor = UIColor.white
        
        return animationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationController.transitionMode = .present
        animationController.startingPoint = view.convert(reviewButton.center, from: reviewsView)
        animationController.circleColor = UIColor.white
        
        return animationController
    }
}
