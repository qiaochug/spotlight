//
//  CollectionViewController.swift
//  spotlight
//
//  Created by Qiaochu Guo on 9/8/18.
//  Copyright © 2018 SpotLight. All rights reserved.
//

import UIKit

let cellId = "cellId"

var navigationtitle = String()

class Post {
    var name: String?
    var statusText: String?
    var statusImageName: String?
}

class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = Post()
        postMark.name = " Recent Updates"
        postMark.statusImageName = "update"
        
        let postSteve = Post()
        postSteve.name = " What's Trending?"
        postSteve.statusImageName = "trump"
        
        let postGandhi = Post()
        postGandhi.name = " My Archive"
        postGandhi.statusImageName = "archive"
        
        
        posts.append(postMark)
        posts.append(postSteve)
        posts.append(postGandhi)
        
        navigationItem.title = "Menu"
        navigationtitle = navigationItem.title!
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white:1, alpha: 1)
        
        collectionView?.register(OptionCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection numberOfItemInSection: Int) -> Int{
        return posts.count
    }
    
    override func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let OptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OptionCell
        OptionCell.post = posts[indexPath.item]
        return OptionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 8+44+8+16+232-20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "collection") as! CollectionViewController
        viewController.navigationtitle_local = posts[indexPath.item].name!
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        return header
    }
    
}

class Header: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("Init(coder:) has not been implemented")
    }
    
    let searchbar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    func setupViews() {
        
        addSubview(searchbar)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: searchbar)
    }
}

class OptionCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            if let name = post?.name{
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                
                nameLabel.attributedText = attributedText
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
            
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("Init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor(red: 19/255, green: 206/255, blue: 102/255, alpha: 0.09)
        return label
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(statusImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: statusImageView)
        addConstraintsWithFormat(format: "V:|[v0(60)][v1(230)]|", views: nameLabel, statusImageView)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}


