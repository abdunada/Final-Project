//
//  TagsVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 25/05/2022.
//

import UIKit
import NVActivityIndicatorView

class TagsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tagsCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var loaderActivityIndicatorViewOutlet: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagsCollectionViewOutlet.delegate = self
        tagsCollectionViewOutlet.dataSource = self
        
        loaderActivityIndicatorViewOutlet.startAnimating()
        PostAPI.getAllTags { tags in
            
            self.loaderActivityIndicatorViewOutlet.stopAnimating()
            self.tags = tags
            self.tagsCollectionViewOutlet.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserManager.loggedInUser != nil {
            navigationController?.navigationBar.isHidden = true
        }
        
//        if UserManager.loggedInUser != nil {
//            navigationController?.navigationBar.isHidden = true
//        }
    }
    
    // MARK: - Varibles
    var tags: [String] = []
}

extension TagsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCVC", for: indexPath) as! TagCVC
        let currentTag = tags[indexPath.row]
        cell.tagNameLabelOutlet.text = currentTag
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedTag = tags[indexPath.row]
        
        if let page = storyboard?.instantiateViewController(withIdentifier: "PostsVC") as? PostsVC {
            
            page.tag = selectedTag
//            self.present(page, animated: true, completion: nil)
            navigationController?.pushViewController(page, animated: true)
        }
    }
}
