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
    
    private var availableWidth: CGFloat = 0
    
    private var itemLength: CGFloat = 0
    
    private var loading: Bool = false
    
    private var dataSource: PhotosModel?
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        // 计算出一页有多少条数据
        let width = UIScreen.main.bounds.inset(by: view.safeAreaInsets).width
        let heitgh = UIScreen.main.bounds.inset(by: view.safeAreaInsets).height
        let columnCount = (width / 80).rounded(.towardZero)
        let itemLength = (width - ((columnCount - 1) * 2)) / columnCount
        self.availableWidth = width
        let hCount = (heitgh / itemLength).rounded(.up)
        let pageCount = columnCount * hCount
        self.itemLength = itemLength
        
        let pixWidth = itemLength * UIScreen.main.scale
        debuglog("pixWidth",pixWidth)
        API.shared.interestingnessGetList(per_page: Int(pageCount)) { [weak self] (result) in
            switch result {
            case let .failure(error):
                fatalError(error.localizedDescription)
            case let .success(value):
                self?.dataSource = value
                self?.adapter.performUpdates(animated: false, completion: nil)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: ListAdapterDataSource

extension MainViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataSource?.photo ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = ImageViewSectionController(itemSize: CGSize(width: self.itemLength, height: self.itemLength))
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}


extension MainViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let dataSource = self.dataSource else {
            fatalError()
        }
        
        guard dataSource.photo.count < dataSource.total else {
            // 数据加载完成
            debuglog("数据加载完成", dataSource.photo.count,dataSource.total)
            return
        }
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            
            adapter.performUpdates(animated: true, completion: nil)
            
            API.shared.interestingnessGetList(date: Date(), page: dataSource.page + 1, per_page: dataSource.perpage) { (result) in
                
                switch result {
                case let .failure(error):
                    fatalError(error.localizedDescription)
                case let .success(value):
                    DispatchQueue.main.async {
                        self.loading = false
                        self.dataSource?.page = value.page
                        self.dataSource?.total = value.total
                        self.dataSource?.photo = dataSource.photo + value.photo
                        
                        
                        let count = dataSource.photo.count + value.photo.count
                        if count > value.total {
                            self.dataSource?.photo.removeLast(count - value.total)
                        }
                        
                        self.adapter.performUpdates(animated: true, completion: nil)
                    }
                    
                } // switch
            
            } // interestingnessGetList
            
        } // if
        
    } // func
    
}


extension MainViewController: ImageViewSectionControllerDelegate {
    func didSelectItem(_ itemData: PhotoModel?) {
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController,let data = itemData else {
            fatalError()
            
        }
        
        vc.dataSource = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}

protocol ImageViewSectionControllerDelegate: class {
    func didSelectItem(_ itemData: PhotoModel?)
}


// MARK: ImageViewSectionController
final class ImageViewSectionController: ListSectionController,ListWorkingRangeDelegate {
    
    private var object: PhotoModel?
    weak var delegate: ImageViewSectionControllerDelegate?
    
    var itemSize: CGSize = CGSize.zero
    
    override init() {
        super.init()
        minimumLineSpacing = 2
        minimumInteritemSpacing = 2
    }
    
    convenience init(itemSize: CGSize) {
        self.init()
        self.itemSize = itemSize
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return self.itemSize
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ImageCollectionViewCell",
                                                                   bundle: nil,
                                                                   for: self,
                                                                   at: index) as? ImageCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.imageView.kf.setImage(with: object!.getImageURL(size: self.itemSize))
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? PhotoModel
    }

    override func didSelectItem(at index: Int) {
        delegate?.didSelectItem(self.object)
    }
    
    
    // ListWorkingRangeDelegate
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        if let cell = self.collectionContext?.cellForItem(at: 1, sectionController: self) as? ImageCollectionViewCell {
            cell.imageView.kf.setImage(with: object!.getImageURL(size: self.itemSize))
        } else {
            fatalError()
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
        
    }
    


}




