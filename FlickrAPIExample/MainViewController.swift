//
//  MainViewController.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import UIKit
import IGListKit
import Kingfisher

final class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [PhotoModel] = []
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        API.shared.interestingnessGetList { [weak self] (result) in
            switch result {
            case let .failure(error):
                fatalError(error.localizedDescription)
            case let .success(value):
                debuglog("加载数据",value.count)
                self?.dataSource = value
                self?.adapter.performUpdates(animated: false, completion: nil)
            }
        }
        
        // Do any additional setup after loading the view.
    }


}

// MARK: ListAdapterDataSource

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = ImageViewSectionController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension MainViewController: ImageViewSectionControllerDelegate {
    func didSelectItem(_ itemData: PhotoModel?) {
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController,let data = itemData else {
            fatalError()
            
        }
        vc.dataSource = data
        self.navigationController?.pushViewController(vc, animated: true)
        
        if #available(iOS 13.0, *) {

        } else {
            // Fallback on earlier versions
             
        }

    }
    
    
}

protocol ImageViewSectionControllerDelegate: class {
    func didSelectItem(_ itemData: PhotoModel?)
}

final class ImageViewSectionController: ListSectionController {

    private var object: PhotoModel?
    weak var delegate: ImageViewSectionControllerDelegate?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ImageCollectionViewCell",
                                                                   bundle: nil,
                                                                   for: self,
                                                                   at: index) as? ImageCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.imageView.kf.setImage(with: object!.imageURL)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? PhotoModel
    }

    override func didSelectItem(at index: Int) {
        delegate?.didSelectItem(self.object)
    }

}

