//
//  PostDetailsVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 18/04/2022.
//

import UIKit
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var userStackViewOutlet: UIStackView!
    @IBOutlet weak var loaderIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var userImageViewOutlet: UIImageView!
    @IBOutlet weak var userNameLabelOutlet: UILabel!
    @IBOutlet weak var postTextLabelOutlet: UILabel!
    @IBOutlet weak var postImageViewOutlet: UIImageView!
    @IBOutlet weak var tagCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var likesImageViewOutlet: UIImageView!
    @IBOutlet weak var likesLabelOutlet: UILabel!
    @IBOutlet weak var commentTableViewOutlet: UITableView!
    @IBOutlet weak var newCommentTextFieldOutlet: UITextField!
    @IBOutlet weak var newCommentStackViewOutlet: UIStackView!
    
    // MARK: - Variables
    var post: Post!
    var comments: [Comment] = []
    var tags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Hide NewComment StackView
        if UserManager.loggedInUser == nil {
           
            newCommentStackViewOutlet.isHidden = true
        }
        // MARK: - Hide Navigation Bar is false
        navigationController?.navigationBar.isHidden = false
        
        // MARK: - make cornerRadius of newComment Text Field
        newCommentTextFieldOutlet.layer.cornerRadius = 15
        
        // MARK: - CollectionView Delegat & DataSource
        tagCollectionViewOutlet.delegate = self
        tagCollectionViewOutlet.dataSource = self
        
        // MARK: - tableView delegat & dataSource
        commentTableViewOutlet.delegate = self
        commentTableViewOutlet.dataSource = self
        
        // MARK: - post present
        if let image = post.owner.picture {
            userImageViewOutlet.setImageFromStringURL(stringURL: image)
        }
        userImageViewOutlet.makeCircularImage()
        userNameLabelOutlet.text = post.owner.firstName + " " + post.owner.lastName
        postTextLabelOutlet.text = post.text
        postImageViewOutlet.setImageFromStringURL(stringURL: post.image)
        postImageViewOutlet.layer.cornerRadius = 15
        likesLabelOutlet.text = String(post.likes)
        
        tags = post.tags ?? []
        
        
        getPostComment()
    }

    // MARK: - Actions
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        
        let message = newCommentTextFieldOutlet.text!
        
        if let loggedInUser = UserManager.loggedInUser {
            
            loaderIndicatorView.startAnimating()
            PostAPI.addNewCommentToPost(postId: post.id, userId: loggedInUser.id, message: message) {
                self.getPostComment()
                self.newCommentTextFieldOutlet.text = nil
            }
        }
        
    }
    
    // MARK: - func Get post comment
    func getPostComment() {
        loaderIndicatorView.startAnimating()
        PostAPI.getComment(id: post.id) { commentResponse in
            self.comments = commentResponse
            self.commentTableViewOutlet.reloadData()
            self.loaderIndicatorView.stopAnimating()
        }
    }
}

extension PostDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVC") as! CommentTVCell
        
        let currentComment = comments[indexPath.row]
        cell.usernameLabelOutlet.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
        cell.commentLabelOutlet.text = currentComment.message
        
        if let userImage = currentComment.owner.picture {
            
            cell.userImageViewOutlet.setImageFromStringURL(stringURL: userImage)
        }
        cell.userImageViewOutlet.makeCircularImage()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 105
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
}

extension PostDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostDetailsTagCVC", for: indexPath) as! PostDetailsTagCVC
        cell.tagNameLabelOutlet.text = tags[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.45, height: collectionView.frame.width * 0.15)
    }
}
