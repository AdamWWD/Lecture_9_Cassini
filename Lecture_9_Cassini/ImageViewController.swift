//
//  ImageViewController.swift
//  Lecture_9_Cassini
//
//  Created by adamwang on 2018/1/18.
//  Copyright © 2018年 adamwang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL? {
        didSet {
            imageView.image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    var imageView = UIImageView()
    
    private func fetchImage(){
        if let url = imageURL {
            do {
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents {
                    image = UIImage(data: imageData)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.demo
            
        }
    }
}
