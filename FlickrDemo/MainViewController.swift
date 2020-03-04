//
//  MainViewController.swift
//  FlickrDemo
//
//  Created by haoshuai on 2020/3/4.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    private var _availableWidth: CGFloat = 0
    
    private var itemLength: CGFloat = 0
    
    private var loading: Bool = false
    
//    private var isMore: Bool = true
    
    private var dataSource: PhotosModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.collectionView.contentInsetAdjustmentBehavior = .always
        self.collectionView.alwaysBounceHorizontal = false
        
        // 计算出一页有多少条数据
        let width = UIScreen.main.bounds.inset(by: view.safeAreaInsets).width
        let heitgh = UIScreen.main.bounds.inset(by: view.safeAreaInsets).height
        let columnCount = (width / 80).rounded(.towardZero)
        let itemLength = (width - ((columnCount - 1) * 2)) / columnCount
        let hCount = (heitgh / itemLength).rounded(.up)
        let pageCount = columnCount * hCount
        self.itemLength = itemLength
        
//        let pixWidth = itemLength * UIScreen.main.scale
//        debuglog("pixWidth",pixWidth)
        API.shared.interestingnessGetList(per_page: Int(pageCount)) { [weak self] (result) in
            switch result {
            case let .failure(error):
                fatalError(error.localizedDescription)
            case let .success(value):
                self?.dataSource = value
                self?.collectionView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = view.bounds.inset(by: view.safeAreaInsets).width

        // Adjust the item size if the available width has changed.
        if _availableWidth != width {
            
            _availableWidth = width
            let columnCount = (width / 80).rounded(.towardZero)
            let itemLength = (width - ((columnCount - 1) * 2)) / columnCount
            
            collectionViewFlowLayout.itemSize = CGSize(width: itemLength, height: itemLength)
            collectionViewFlowLayout.minimumLineSpacing = 2
            collectionViewFlowLayout.minimumInteritemSpacing = 2
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: false)
        }
    }
    
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debuglog("多少条数据",dataSource?.photo.count ?? 0)
        return dataSource?.photo.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageViewCell", for: indexPath) as? ImageViewCollectionViewCell else {
            fatalError()
        }

        guard let photos = self.dataSource?.photo else {
            fatalError()
        }
        

        cell.imageView.kf.indicatorType = .activity
        let imageView = cell.imageView
        let url = photos[indexPath.item].getImageURL(size: CGSize(width: self.itemLength, height: self.itemLength))
        imageView?.kf.setImage(
              with: url,
              placeholder: nil,
              options: [.transition(.fade(1)), .loadDiskFileSynchronously],
              progressBlock: { receivedSize, totalSize in
//                  print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
              },
              completionHandler: { result in
//                  print(result)
//                  print("\(indexPath.row + 1): Finished")
              }
          )
        return cell
        
    }
    
    
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let photos = self.dataSource?.photo else {
            fatalError()
        }
        let urls = indexPaths.compactMap { (index) -> URL in
            let url = photos[index.item].getImageURL(size: CGSize(width: self.itemLength, height: self.itemLength))
            return url
        }
        ImagePrefetcher(urls: urls).start()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let photos = self.dataSource?.photo else {
            fatalError()
        }
        guard let cell = cell as? ImageViewCollectionViewCell else {
            fatalError()
        }
        
        let imageView = cell.imageView
        let url = photos[indexPath.item].getImageURL(size: CGSize(width: self.itemLength, height: self.itemLength))
        imageView?.kf.setImage(
              with: url,
              placeholder: nil,
              options: [.transition(.fade(1)), .loadDiskFileSynchronously],
              progressBlock: { receivedSize, totalSize in
//                  print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
              },
              completionHandler: { result in
//                  print(result)
//                  print("\(indexPath.row + 1): Finished")
              }
          )
        
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // 清除下载线程
        guard let cell = cell as? ImageViewCollectionViewCell else {
            fatalError()
        }
        let imageView = cell.imageView
        imageView?.kf.cancelDownloadTask()
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.dataSource?.photo[indexPath.item] else {
            fatalError()
        }

        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else {
            fatalError()
        }
        
        vc.dataSource = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        debuglog("滑动完成 需要缓存数据")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        debuglog("需要加载更多数据")
        guard let dataSource = self.dataSource else {
            fatalError()
        }
        
        if dataSource.total <= dataSource.photo.count {
            debuglog("已经加载完成", dataSource.total,dataSource.photo.count)
            return
        }
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        
        if !loading && distance < 200 {
            
            loading = true
            
            API.shared.interestingnessGetList(date: Date(), page: dataSource.page + 1, per_page: dataSource.perpage) { (result) in
                
                switch result {
                case let .failure(error):
                    fatalError(error.localizedDescription)
                case let .success(value):
//                    DispatchQueue.main.async {
                        
                        self.loading = false
                        self.dataSource?.page = value.page
                        self.dataSource?.total = value.total
                        self.dataSource?.photo = dataSource.photo + value.photo
                        debuglog("获取的数据",value.perpage,dataSource.photo.count,value.photo.count)
                        let count = dataSource.photo.count + value.photo.count
                        if count > value.total {
                            self.dataSource?.photo.removeLast(count - value.total)
                        }

                        self.collectionView.reloadData()
//                    }
                    
                } // switch
            
            } // interestingnessGetList
            
        } // if
        
    } // func
    
}
