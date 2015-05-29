//
//  ViewController.swift
//  Mover
//
//  Created by IHSOFT on 2015. 5. 15..
//  Copyright (c) 2015년 IHSOFT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // For Intro image
    var pageController: UIPageViewController?
    var pageContent = NSArray()
    let INTRO_IMAGE_COUNT = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a new view controller and display view
         showMasterLoginPage()
        
        // smlee : 2015/05/15
        // Create and show Intro page only first one.
//        self.createIntroPage()
//        self.showIntroPage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add intro image file
    func createIntroPage() {
        var imageIntro = [String]()
        
        for i in 1...INTRO_IMAGE_COUNT {
            let stringIntroFile = "Intro_main_\(i).png"
            imageIntro.append(stringIntroFile)
        }
        
        pageContent = imageIntro        
    }
    
    func showIntroPage() {
        self.pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageController?.delegate = self
        self.pageController?.dataSource = self
        
        let startingViewController: IntroViewController = self.viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        
        self.pageController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        
        self.addChildViewController(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        self.pageController!.view.frame = self.view.bounds
        self.pageController!.didMoveToParentViewController(self)
    }
    
    // make Master login view
    func showMasterLoginPage() {
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let loginViewController = storyBoard.instantiateViewControllerWithIdentifier("masterLogin") as! LoginViewController
        self.presentViewController(loginViewController, animated: true, completion: nil)
        
    }
    
    func viewControllerAtIndex(index: Int) -> IntroViewController? {
        
        NSLog("\(__FUNCTION__) : \(index)")
        
        if (self.pageContent.count == 0) {
            return nil
        } else if (index >= self.pageContent.count) {
            self.pageController?.dismissViewControllerAnimated(false, completion: nil)
            // display login
            showMasterLoginPage()
            
            // 인트로화면을 보고 나면 파일 또는 디비에 셋팅한다.
            
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let dataViewController = storyBoard.instantiateViewControllerWithIdentifier("introView") as! IntroViewController
        
        dataViewController.dataObject = pageContent[index]
        return dataViewController
    }
    
    func indexOfViewController(ViewController: IntroViewController) -> Int {
        if let dataObject: AnyObject = ViewController.dataObject {
            return self.pageContent.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) ->  UIViewController? {
            
        NSLog("\(__FUNCTION__)")
        var index = self.indexOfViewController(viewController as! IntroViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        NSLog("\(__FUNCTION__)")
        var index = self.indexOfViewController(viewController as! IntroViewController)
        if index == NSNotFound {
            return nil
        }
        
        if index == self.pageContent.count {
            return nil
        }
        index++
        
        return self.viewControllerAtIndex(index)
    }
    
}

