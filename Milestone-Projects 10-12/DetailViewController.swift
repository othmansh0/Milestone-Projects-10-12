//
//  DetailViewController.swift
//  Milestone-Projects 10-12
//
//  Created by othman shahrouri on 9/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var fullImage: UIImageView!
    var imageName:String!
    var imageCaption:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        fullImage.image = UIImage(contentsOfFile: imageName)
        title = imageCaption
     
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
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
