

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var img: UIImageView!
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        img.layer.cornerRadius = img.frame.size.width/2;
        img.clipsToBounds = true
        tap();
        
    }

    @IBAction func btn_insert(_ sender: Any) {
        let obj = sqltask();
        let imgname = txt_name.text!+".jpg";
        let qurey = "insert into tbl (name,email,image) values ('\(txt_name.text!)','\(txt_email.text!)','\(imgname)');"
        let  st = obj.insertdata(dml: qurey);
        
        if st == true{
            
            self.SaveImageInDocument(imagename: imgname, imagedata: img.image!);
            
            let nav = storyboard?.instantiateViewController(withIdentifier: "login") as! login;
            self.navigationController?.pushViewController(nav, animated: true);
        }
        
        
        
    
    }
    
    
    func SaveImageInDocument(imagename:String,imagedata:UIImage){
        let fmg = FileManager.default;
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename);
        let img = UIImageJPEGRepresentation(imagedata, 2);
        fmg.createFile(atPath: path, contents:img, attributes: nil);
        
        print(path);
    }
    func tap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handle))
        tap.numberOfTapsRequired = 1;
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tap);
    }
    func handle(sender: UITapGestureRecognizer) {
        picker.sourceType = .photoLibrary
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }

}

