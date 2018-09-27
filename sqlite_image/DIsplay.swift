
import UIKit

class DIsplay: UIViewController {

    var getid:String="";
    var arr :[Any] = []
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata();
        print(getid);
    }
    func getdata()  {
        let obj = sqltask();
        let query = "select * from tbl where id = '\(getid)'"
        arr = obj.getdata(query: query);
        let  brr1 =  arr[0] as! [String];
        
        txt_name.text = brr1[1]
        txt_email.text = brr1[2]
        let imgname = brr1[3]
        img.image = getImage(imgname: imgname)
        img
            .layer.cornerRadius = self.img.frame.size.width / 2;
        //   img.layer.cornerRadius = self.img.frame.size.height/2;
        img.clipsToBounds = true
        
        
    }
    
    func getImage(imgname:String)->UIImage {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imgname)
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)!
        }else{
            
            return UIImage(named: "log.jpeg")!;
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
  
}
