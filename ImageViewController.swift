//
//  ImageViewController.swift
//  Cassini
//
//  Created by Onder Kalaci on 04/07/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    {
        didSet
        {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.00
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageURL: NSURL?
    {
        didSet
        {
            image = nil
            
            if view.window != nil
            {
                fetchImage()
            }
        }
    }
    private var imageView = UIImageView()
    
    private var image: UIImage?
    {
        get { return imageView.image }
        set {
                imageView.image = newValue
                imageView.sizeToFit()
            
                scrollView?.contentSize = imageView.frame.size
            }
    }
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    private func fetchImage()
    {
        if let url = imageURL
        {
            spinner?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            
            dispatch_async(dispatch_get_global_queue(qos,0))
            {
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue())
                {
                    self.spinner.stopAnimating()
                    if url == self.imageURL
                    {
                        if imageData != nil
                        {
                            self.image = UIImage(data: imageData!)
                        }
                        else
                        {
                            
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if image == nil
        {
            fetchImage()
        }
    }
}
