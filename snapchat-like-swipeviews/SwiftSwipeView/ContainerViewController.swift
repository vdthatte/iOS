//
//
// Working on top of Brendan Lee's bubble_ios
//
//

import UIKit

class ContainerViewController: UIViewController {
    
    // Outlet used in storyboard
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var scrollViewVertical: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // 1) Create the three views used in the swipe container view
        var AVc :AViewController =  AViewController(nibName: "AViewController", bundle: nil);
        var BVc :BViewController =  BViewController(nibName: "BViewController", bundle: nil);
        var CVc :CViewController =  CViewController(nibName: "CViewController", bundle: nil);
        var DVc :DViewController =  DViewController(nibName: "DViewController", bundle: nil);
        
        // 2) Add in each view to the container view hierarchy
        //    Add them in opposite order since the view hieracrhy is a stack
        self.addChildViewController(CVc);
        self.scrollView!.addSubview(CVc.view);
        CVc.didMoveToParentViewController(self);

        self.addChildViewController(BVc);
        self.scrollView!.addSubview(BVc.view);
        BVc.didMoveToParentViewController(self);
        
        self.addChildViewController(DVc);
        self.scrollViewVertical!.addSubview(DVc.view);
        DVc.didMoveToParentViewController(self);
        
        self.addChildViewController(AVc);
        self.scrollView!.addSubview(AVc.view);
        AVc.didMoveToParentViewController(self);
        
        
        // 3) Set up the frames of the view controllers to align
        //    with eachother inside the container view
        var adminFrame :CGRect = AVc.view.frame;
        adminFrame.origin.x = adminFrame.width;
        AVc.view.frame = adminFrame;
        
        var BFrame :CGRect = BVc.view.frame;
        BFrame.origin.x = 2*BFrame.width;
        CVc.view.frame = BFrame;
        
        var CFrame : CGRect = CVc.view.frame
        CFrame.origin.x = 2*CFrame.width
        CVc.view.frame = CFrame
        
        var DFrame : CGRect = DVc.view.frame
        DFrame.origin.y = -DFrame.height
        DFrame.origin.x = 0
        DVc.view.frame = DFrame

        // 4) Finally set the size of the scroll view that contains the frames
        var scrollWidth: CGFloat  = 3 * self.view.frame.width
        var scrollHeight: CGFloat = self.view.frame.height
        self.scrollView!.contentSize = CGSizeMake(scrollWidth, scrollHeight);
        
        var scrollWidthVertical: CGFloat = 2 * self.view.frame.width
        var scrollHeightVertical: CGFloat = 2 * self.view.frame.height
        self.scrollViewVertical!.contentSize = CGSizeMake(scrollWidthVertical, scrollHeightVertical);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

