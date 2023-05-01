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

class NotificationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var notifications = [Notification(message: "안녕", time: "1시간전"), Notification(message: "안녕", time: "2시간전"), Notification(message: "안녕", time: "3시간전")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    static func getInstanse() -> NotificationViewController{
        guard let vc =  UIStoryboard(name: "Notification", bundle: nil).instantiateViewController(withIdentifier: "notification") as? NotificationViewController
        else {
            fatalError()
        }
        return vc
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

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notifications[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
