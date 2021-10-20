//
//  ListViewModelType.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

protocol ListViewModelType {
    var title: String { get }
    var list: List? { get set }
    var service: ListServiceType { get }
    
    var didRetrieveItems: (() -> Void)? { get set }
    var didFailRetrieveItems: (() -> Void)? { get set }

    func getList()
    func numberOfItems() -> Int
    func item(at index: Int) -> Item?
    func isLastItemReached(at indexPath: IndexPath) -> Bool
}
