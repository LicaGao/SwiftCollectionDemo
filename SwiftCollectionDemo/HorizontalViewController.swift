//
//  HorizontalViewController.swift
//  SwiftCollectionDemo
//
//  Created by 高鑫 on 2017/12/6.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class HorizontalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let imgs = ["a","b","c","d","e","f","g"]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = HorizontalCollectionViewLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hCell", for: indexPath) as! HorizontalCollectionViewCell
        cell.img.image = UIImage(named: imgs[indexPath.item])
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class HorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    
}
