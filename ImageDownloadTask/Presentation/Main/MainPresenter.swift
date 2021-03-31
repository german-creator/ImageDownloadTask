//
//  MainPresenter.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import Foundation


final class MainPresenter {
    private weak var viewInput: MainViewInput?
    private let service: ImageService
    private var imageDataArray: [ImageData] = []
    private var searchText: String?
    
    private var offset = 0
    private var limit = Constants.queryDataLimit
    private var didSearch = false
    private var isLoading = false
    
    private var isSearching: Bool {
        return searchText != nil
    }
    
    init(service: ImageService) {
        self.service = service
    }
    
    private func loadBaseImage() {
        guard !isLoading else {
            return
        }
        
        if didSearch {
            offset = 0
        }
        
        isLoading = true
        
        service.getBaseImage(offset: offset) { [weak self] result in
            do {
                let downloadedData = try result.get()
                self?.handleDownloadedTrends(data: downloadedData)
            } catch {
                self?.handle(error: error)
            }
        }
    }
    
    private func loadSearch(text: String) {
        service.search(query: text, offset: offset, completion: { [weak self] result in
            do {
                let downloadedData = try result.get()
                self?.handleDownloadedSearch(data: downloadedData, searchText: text)
            } catch {
                self?.handle(error: error)
            }
        })
    }
    
    private func handle(error: Error) {
        viewInput?.setErrorView(hidden: false)
        isLoading = false
    }
    
    private func handleDownloadedTrends(data: [ImageData]) {
        viewInput?.setNoResultsView(hidden: true)
        
        if didSearch {
            reload(data: data)
            didSearch = false
        } else {
            add(data: data)
        }
        
        handleFinishDownloading()
    }
    
    private func handleDownloadedSearch(data: [ImageData], searchText: String) {
        viewInput?.setNoResultsView(hidden: true)
        
        guard !data.isEmpty else {
            isLoading = false
            viewInput?.setNoResultsView(hidden: false)
            return
        }
        
        if isSearching, self.searchText == searchText {
            add(data: data)
        } else {
            reload(data: data)
        }
        
        handleFinishDownloading()
        
        self.searchText = searchText
    }
    
    private func reload(data: [ImageData]) {
        imageDataArray = data
        viewInput?.reloadData()
        viewInput?.scrollToTop()
    }
    
    private func add(data: [ImageData]) {
        imageDataArray.append(contentsOf: data)
        viewInput?.reloadData()
    }
    
    private func handleFinishDownloading() {
        viewInput?.setErrorView(hidden: true)
        isLoading = false
        offset += limit
    }
}


extension MainPresenter: MainViewOutput {
    func set(loading: Bool) {
        isLoading = loading
    }
    
    func refresh() {
        loadBaseImage()
    }
    
    func didSearch(text: String) {
        guard !isLoading else {
            return
        }
        
        if !didSearch {
            offset = 0
        }
        
        didSearch = true
        isLoading = true
        
        guard !text.isEmpty else {
            isLoading = false
            searchText = nil
            loadBaseImage()
            return
        }
        
        loadSearch(text: text)
    }
    
    func cellModels() -> [ImageCellModel] {
        
        return imageDataArray.map({ $0.asImageCellModel() })
    }
    
    func set(viewInput: MainViewInput) {
        self.viewInput = viewInput
    }
    
    func viewDidLoad() {
        loadBaseImage()
    }
    
    func didScrollAlmostToEnd() {
        if isSearching {
            didSearch(text: searchText ?? "")
        } else {
            loadBaseImage()
        }
    }
}


extension ImageData {
    func asImageCellModel() -> ImageCellModel {
             
        let ratio = Float(height) / Float(width)
        return DefaultImageCellModel(imageUrl: url, tags: tags, sizeRatio: ratio)
    }
}
