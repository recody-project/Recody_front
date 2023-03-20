//
//  NotificationViewController.swift
//  Recody
//
//  Created by 마경미 on 20.03.23.
//

import UIKit

struct Notification {
    var message: String
    var time: String
}

class NotificationViewController: CommonVC {
    @IBOutlet weak var tableView: UITableView!
    var notifications = [Notification(message: "안녕", time: "1시간전"), Notification(message: "안녕", time: "2시간전"), Notification(message: "안녕", time: "3시간전")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerXib() {
        let nibName = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "notificationTableViewCell")
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableViewCell", for: indexPath) as? NotificationTableViewCell else {
            return UITableViewCell()
        }

        cell.setData(data: notifications[indexPath.row])
        cell.backgroundColor = UIColor.clear.withAlphaComponent(0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notifications[indexPath.row])
    }
}
