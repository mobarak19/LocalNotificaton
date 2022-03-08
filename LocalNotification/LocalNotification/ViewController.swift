//
//  ViewController.swift
//  LocalNotification
//
//  Created by Mobarak on 3/8/22.
//

import UIKit

import UserNotifications
class ViewController: UIViewController , UNUserNotificationCenterDelegate{

    let showBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Show Notification", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let notificationCenter  = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()

        setShowButton()
       setNotificatonRequest()
        
    }
    func setShowButton() {
        showBtn.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(showBtn)
        showBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        showBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        showBtn.widthAnchor.constraint(equalToConstant: 160).isActive = true
        showBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        showBtn.addTarget(self, action: #selector(onTappedBtn), for: .touchUpInside)
    }
    
     @objc func onTappedBtn()  {
         let content = UNMutableNotificationContent()
         content.categoryIdentifier = "My Category"
         content.title  = "Notificaton Title"
         content.badge = 1
         content.body = "THis is a notification body"
         content.sound = .default
         
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
         
         let identifire = "notification_identifire"
         
         let request = UNNotificationRequest.init(identifier: identifire, content: content, trigger: trigger)
         
         notificationCenter.add(request) { error in
             if error != nil {
                 print(error as Any)
             }
         }
         let like = UNNotificationAction.init(identifier: "like", title: "Like", options: .foreground)
         let Dislike = UNNotificationAction.init(identifier: "dislike", title: "Dislike", options: .destructive)
         let category = UNNotificationCategory(identifier: content.categoryIdentifier, actions: [like,Dislike], intentIdentifiers: [], options: [])
         notificationCenter.setNotificationCategories([category])

     }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.badge,.sound])
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let vc = SecondVC()
        
        present(vc, animated: true, completion: nil)
    }
    func setNotificatonRequest()  {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if !success {
                print(error as Any)
            }
        }
    }

}


