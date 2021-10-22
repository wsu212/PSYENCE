//
//  ListViewModel.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

final class ListViewModel: ListViewModelType {
    
    let title: String
    
    let service: ListServiceType
    
    var list: List? {
        didSet {
            if let items = list?.items {
                let items = items.filter { $0.isValid }
                self.items += items
            }
        }
    }
    
    var didRetrieveItems: (() -> Void)?

    var didFailRetrieveItems: (() -> Void)?
    
    private var items: [Item] = [] {
        didSet {
            self.didRetrieveItems?()
        }
    }
    
    private var nextPage: Int? {
        guard let currentPage = list?.page else {
            return 1
        }
        guard let lastPage = lastPage, currentPage < lastPage else {
            return nil
        }
        return currentPage + 1
    }
    
    private var lastPage: Int? {
        let url = list?.last ?? ""
        let lastPage = Int(url.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        return lastPage
    }
    
    // MARK: - Initializer
    
    init(title: String, service: ListServiceType) {
        self.title = title
        self.service = service
    }
    
    func getList() {
        guard let nextPage = nextPage else { return }
        
        service.getList(at: nextPage) { [weak self] itemsList, error in
            guard let self = self else { return }
            
            if let list = itemsList {
                self.list = list
            } else {
                self.didFailRetrieveItems?()
            }
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> Item? {
        guard index < items.count else {
            return nil
        }
        return items[index]
    }
    
    func isLastItemReached(at indexPath: IndexPath) -> Bool {
        return indexPath.row == items.count - 1
    }
}
