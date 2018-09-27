
import UIKit

class login: UIViewController {

    var arr:[Any]=[];
    override func viewDidLoad() {
        super.viewDidLoad()

            }

   
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_name: UITextField!

    @IBAction func btn_login(_ sender: Any) {
        
        let obj = sqltask();
        arr = obj.getdata(query: "select * from tbl where name = '\(txt_name.text!)' and email = '\(txt_email.text!)'");
        
        let brr = arr[0] as![String]
        let id = brr[0]
        let nav = storyboard?.instantiateViewController(withIdentifier:"DIsplay")as! DIsplay;
        nav.getid = id;
        self.navigationController?.pushViewController(nav, animated: true);
    }


}
