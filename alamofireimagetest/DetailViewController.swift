//
//  DetailViewController.swift
//  alamofireimagetest
//
//  Created by Alexandros Spyropoulos on 09/05/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
   
    @IBOutlet weak var detailImg: UIImageView!
    


    var detailItem: ImageType? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
            
            if let imgView = self.detailImg {
                detail.load(imgView)
            }
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

