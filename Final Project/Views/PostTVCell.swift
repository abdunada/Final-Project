//
//  PostTVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 29/03/2022.
//

import UIKit

class PostTVCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userStackViewOutlet: UIStackView! {
        didSet {
            userStackViewOutlet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var userImageViewOutlet: UIImageView!
    @IBOutlet weak var usernameLableOutlet: UILabel!
    @IBOutlet weak var postTextLabelOutlet: UILabel!
    @IBOutlet weak var postImageViewOutlet: UIImageView!
    @IBOutlet weak var tagCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var likesImageViewOutlet: UIImageView!
    @IBOutlet weak var likesLabelOutlet: UILabel!
    
    
    // MARK: - Var
    var tags: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // MARK: - CollectionView Delegat & DataSource
        tagCollectionViewOutlet.delegate = self
        tagCollectionViewOutlet.dataSource = self
        
        // MARK: - Post Image CornerRadius
        postImageViewOutlet.layer.cornerRadius = 15
    }
    
    // MARK: - Actions
    @objc func userStackViewTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo: ["cell": self])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension PostTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCVC", for: indexPath) as! PostTagCVC
        cell.tagNameLabelOutlet.text = tags[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.45, height: collectionView.frame.width * 0.15)
    }
}
