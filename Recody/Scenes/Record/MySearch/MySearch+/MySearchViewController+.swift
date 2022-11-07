//
//  MySearchViewController+.swift
//  Recody
//
//  Created by 마경미 on 13.10.22.
//

import Foundation
import UIKit

extension MySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySearchs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchTableViewCell") as? MySearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: mySearchs[indexPath.row], indexPathRow: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension MySearchViewController: TableViewCellDelegate {
    func deleteButton(indexPathRow: Int) {
        print(indexPathRow)
        let indexPath = IndexPath(row: indexPathRow, section: 0)
        self.mySearchs.remove(at: indexPathRow)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData()

    }
}

extension MySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? mySearchs : mySearchs.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
