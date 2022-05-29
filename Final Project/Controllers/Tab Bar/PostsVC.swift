//
//  ViewController.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 27/03/2022.
//

import UIKit

import NVActivityIndicatorView

class PostsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var hiLabelOutlet: UILabel!
    @IBOutlet weak var logoutButtonOutlet: UIButton!
    @IBOutlet weak var loaderIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var postsTableViewOutlet: UITableView!
    @IBOutlet weak var addNewPostContainerViewOutlet: UIView!
    @IBOutlet weak var addNewPostButtonOutlet: UIButton!
    
    // MARK: - variables
    var posts: [Post] = []
    var tag: String?
    var page = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNewPostContainerViewOutlet.layer.cornerRadius = addNewPostContainerViewOutlet.frame.size.width / 2
        addNewPostContainerViewOutlet.clipsToBounds = true
        
        // MARK: - Hide Logout Button
        if UserManager.loggedInUser == nil {
           
            logoutButtonOutlet.isHidden = true
        }
        
        // MARK: - Show Hi label
        if var loggedInUser = UserManager.loggedInUser {
           
            hiLabelOutlet.text = "Hi, \(loggedInUser.firstName.trimmingCharacters(in: .capitalizedLetters))"
            
        } else {
            
            hiLabelOutlet.text = "Guest"
            addNewPostContainerViewOutlet.isHidden = true
        }
        
        // MARK: - tableView delegat & dataSource
        postsTableViewOutlet.delegate = self
        postsTableViewOutlet.dataSource = self
        
        // MARK: - Subscribing to the Notification
        // MARK: - User Profile Tapped
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("userStackViewTapped"), object: nil)
        
        // MARK: - Add New Post
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name(rawValue: "NewPostAdded"), object: nil)
        getPosts()
        
    }
    
    // MARK: - Hide Navigation Bar is true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if var tag = tag {
            
            hiLabelOutlet.text = "Tag '\(tag.trimmingCharacters(in: .capitalizedLetters))'"
            titleLabelOutlet.isHidden = true
            navigationController?.navigationBar.isHidden = false
            
        } else if UserManager.loggedInUser != nil {
            navigationController?.navigationBar.isHidden = true
        }
        
//        if UserManager.loggedInUser != nil {
//            navigationController?.navigationBar.isHidden = true
//        }
    }
    // MARK: - Actions
    @IBAction func logoutButtonPressed(_ sender: Any) {
       
        let alert = UIAlertController(title: "Attention", message: "Do you want to logout?", preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "OK", style: .destructive) { logout in
           
            if let page = self.storyboard?.instantiateViewController(withIdentifier: "UserPageVC") as? UserPageVC {
                self.navigationController?.popViewController(animated: true)
                UserManager.loggedInUser = nil
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(oKAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addNewPostButtonPressed(_ sender: Any) {
        
        if  let page = storyboard?.instantiateViewController(withIdentifier: "AddNewPostVC") as? AddNewPostVC {
            
            navigationController?.pushViewController(page, animated: true)
        }
    }
    // MARK: - Get Posts
    func getPosts() {
        // MARK: - Start loaderIndicatorView
        loaderIndicatorView.startAnimating()
       
        // MARK: - Get All Posts
        PostAPI.getAllPosts(page: page, tag: tag) { postsResponse, total in
            
            self.total = total
            self.posts.append(contentsOf: postsResponse)
            self.postsTableViewOutlet.reloadData()
            
            // MARK: - Stop loaderIndicatorView
            self.loaderIndicatorView.stopAnimating()
        }
    }
    
    
    
    // MARK: - User Profile Tapped
    @objc func userProfileTapped(notification: Notification) {
        
        if let cell = notification.userInfo?["cell"] as? PostTVCell {
            
            if let indexPath = postsTableViewOutlet.indexPath(for: cell) {
                let post = posts[indexPath.row]
                
                let page = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                
                page.user = post.owner
                navigationController?.pushViewController(page, animated: true)
            }
        }
    }
    
    // MARK: - newPostAdded
   @objc func newPostAdded() {
        self.posts = []
        self.page = 0
        getPosts()
    }
}

extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postsTableViewOutlet.dequeueReusableCell(withIdentifier: "PostTVC") as! PostTVCell
        let post = posts[indexPath.row]
        cell.postTextLabelOutlet.text = post.text
        
        let imageStringUrl = post.image
        cell.postImageViewOutlet.setImageFromStringURL(stringURL: imageStringUrl)
        // MARK: - Picture
        let pictureStringUrl = post.owner.picture
        cell.userImageViewOutlet.makeCircularImage()
        
        if let image = pictureStringUrl {
            cell.userImageViewOutlet.setImageFromStringURL(stringURL: image)
        }
        
        
        // MARK: - username label
        cell.usernameLableOutlet.text = post.owner.firstName + " " + post.owner.lastName
        // MARK: - Likes
        cell.likesLabelOutlet.text = String(post.likes)
        
        cell.tags = post.tags ?? []
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 600
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: [indexPath.row], animated: true)
        let selectedPost = posts[indexPath.row]
        
        if let page = storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as? PostDetailsVC {
            page.post = selectedPost
            
            navigationController?.pushViewController(page, animated: true)
//            page.modalPresentationStyle = .fullScreen
//            page.modalTransitionStyle = .coverVertical
//            present(page, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1 && posts.count < total {
            page = page + 1
            getPosts()
        }
    }
}
