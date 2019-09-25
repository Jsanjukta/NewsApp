//
//  DetailViewController.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewNews: UIImageView!
    var strTitle : String?
    var strContent : String?
    var imgUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designAfterStoryBoard()
        // Do any additional setup after loading the view.
    }
    
    func designAfterStoryBoard(){
        self.title = "News Details"
        setImage()
        lblContent.text  = strContent
        lblTitle.text  = strTitle
    }
    
    func setImage(){
        guard let url = imgUrl else {
            return
        }
        APIManager.sharedInstance.getImageData(from: URL(string:  url)! ){ (data, response, error) in
            if let error = error {
                print("Get image error: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.imgViewNews.image = UIImage(data: data ?? Data())
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
