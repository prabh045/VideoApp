//
//  ViewController.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 28/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    var selectedCategoryIndex = 0
    var selectedVideoIndex = 0
    
    var videoData: Array<VideoModel> = []
    let presentAnimator = Animator()
    let dismissAnimator = DismissAnimator()
    var selectedCellFrame = CGRect.zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupStackView()
        videoData = VideoService.loadDataFrom(name: "assignment")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
           navigationController?.navigationBar.shadowImage = UIImage()
        setupUI()
    }
    
    //MARK: SetUp Views
    func setupUI() {
        for i in 1...videoData.count {
            print(i)
            setupLabel(index: i)
            setupCollectionViewWith(tag: i)
        }
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        self.view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupStackView() {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 15
        self.scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
    func setupLabel(index: Int) {
        let label = UILabel()
        label.text = videoData[index - 1].title
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        //self.view.addSubview(label)
        stackView.addArrangedSubview(label)
        label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
    }
    
    func setupCollectionViewWith(tag: Int) {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = UIColor.white
        collectionView.tag = tag
        collectionView.showsHorizontalScrollIndicator = false
       
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "VideoThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //self.view.addSubview(collectionView)
        stackView.addArrangedSubview(collectionView)

        collectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

    }
    
    //MARK: CollectionView Delegate Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData[collectionView.tag - 1].nodes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? VideoThumbnailCell else {
            fatalError("Could not initialise cell")
        }
        cell.layer.cornerRadius = 15
        let stringUrl = videoData[collectionView.tag-1].nodes[indexPath.row].video.encodeUrl as NSString
        cell.imageUrl = stringUrl
        cell.getThumbnailImageFromVideoUrl(url: stringUrl) { (image) in
            cell.thumbnailImageView.image = image
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategoryIndex = collectionView.tag-1
        selectedVideoIndex = indexPath.row
        selectedCellFrame = collectionView.convert(collectionView.layoutAttributesForItem(at: indexPath)!.frame, to: self.view)
        performSegue(withIdentifier: "playerScreen", sender: nil)
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerScreen" {
            let vc = segue.destination as? PlayerViewController
            vc?.transitioningDelegate = self
            vc?.videoData = videoData
            vc?.selectedCategoryIndex = selectedCategoryIndex
            vc?.selectedVideoIndex = selectedVideoIndex
        }
    }

}

//MARK: TransitionDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentAnimator.originFrame = selectedCellFrame
        print("Frame is",selectedCellFrame)
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissAnimator.originFrame = selectedCellFrame
        return dismissAnimator
    }
    
}

