import UIKit
//
//
//var kelime:String?="yusuf"
//var yas:Int?=12
//
//if let tempKelime = kelime, let tempYas = yas{
//    print("yas ve kelime nil değil")
//}else{
//    print("ikisinden birisi ya da ikisi de nil")
//}
////çıktı : ikisinden birisi ya da ikisi de nil
//
//
//func guardDeneme(){
//    guard let tempKelime = kelime, let tempYas = yas else {
//        print("ikisinde birisi ya da ikisi de nil")
//        return
//    }
//
//    print("yas ve kelime NİL DEĞİL")
//}
//
//guardDeneme()
//
////çıktı : ikisinde birisi ya da ikisi de nil  üsttekinin aynısı aslında
//

//-------------------------------//--------------------------------//
//func deneme(){
//
//    defer {
//        print("fonksiyon defer..")
//    }
//
//    for i in 0...5{
//        defer {
//            print("döngü defer..")
//        }
//
//        print(i)
//    }
//
//}
//
//deneme()
//
//
//-------------------------------//--------------------------------//
//THROWS VE CATCH

//enum Hatalar:Error{
//    case sifiraBolmeHatasi
//    case bolunecekSayiSifirHatası
//}
//
//
//
//func bol(sayi:Int, sayi2:Int) throws ->Int  {
//    if sayi2==0{
//        throw Hatalar.sifiraBolmeHatasi
//    }else if sayi==0{
//        throw Hatalar.bolunecekSayiSifirHatası
//    }else{
//        return sayi/sayi2
//    }
//}
//
//
//do{
//    let sonuc = try bol(sayi: 30, sayi2: 0)
//    print(sonuc)
//}catch Hatalar.sifiraBolmeHatasi{
//    print("sifira bolunmez")
//}catch Hatalar.bolunecekSayiSifirHatası{
//    print("bölünecek sayı sıfır olamaz")
//}
////
//var isim="Yusuf" as Any
//var isim2=isim as! String
//-------------------------------------------
//let isimDizi = ["Yusuf","Ali","Çezik"]
//let yasDizi = [12,34,67]
//
//func yazdirGeneric<T>(gelenDizi:[T]){
//    for i in gelenDizi{
//        print(i)
//    }
//}
//
//
//yazdirGeneric(gelenDizi: isimDizi)
//yazdirGeneric(gelenDizi: yasDizi)

//----------------------------------------------------

//var dizi=Array(repeatElement("yusuf", count: 10))
//print(dizi)
//
//var yusuf=(isim:"yusuf",yas:21)
//yusuf.isim
//yusuf.0
//yusuf.yas
//yusuf.1
////bi değişkene birden fazla değer atama
//
//

//var iCanDrink=false
//
// iCanDrink  ? print("asd") : print("qwe")
//
//----------------------------------------------------

//
//var sayi = 8
//
//var carpilmisSayi : Int {
//    get{
//        return sayi / 2
//    }
//    set{
//        sayi = newValue * 2
//    }
//}
//
//carpilmisSayi = 99
//sayi
//print(carpilmisSayi)
//----------------------------------------------------


//var isim = "Yusuf"{
//
//    willSet{
//        print("değer değişecek : \(isim)")
//    }
//
//    didSet{
//        print("değer değişti :  \(isim)")
//    }
//}
//
//isim = "Ali çezik" //değişir değişmez didSet metoduna gider..
//print(isim)
//
//


//----------------------------------------------------

//class Insan {
//    var isim:String
//
//    init?(isim:String) {
//        if isim.isEmpty{
//            return nil
//        }
//        self.isim=isim
//    }
//}
//
//var insan=Insan(isim: "yusuf")
//
//if let tempInsan = insan{
//    print(tempInsan.isim)
//}
//
//----------------------------------------------------

//problem : 1-2,1-4,5-7,6-6 //Veritabanından tek columndan gelen stringi parçalama algoritması ;


let gunDic=["1":"Pazartesi","2":"Salı","3":"Çarşamba"] //...4,5,6...

let saatDic=["1":"08:00","2":"09:00","3":"10:00","4":"11:00"] //...5,6,7...



var gelenString="1-2,2-4,1-3,2-3"


func parcala(gelenString:String)->([String],[String]){
    
    var gunlerArray=[String]()
    var saatlerArray=[String]()
    
    let ilkAyrilmisDizi=gelenString.split(separator: ",") //1-2   1-4  ....
    for i in 0..<ilkAyrilmisDizi.count {
       let ikinciAyrilmisDizi = ilkAyrilmisDizi[i].split(separator: "-") // 1  2
       gunlerArray.append(String(ikinciAyrilmisDizi[0])) // 1 -) pazartesi     1-) Pazartesi
        saatlerArray.append(String(ikinciAyrilmisDizi[1])) // 2 -) saat 09:00    4-) Saat 11:00
    }
    return (gunlerArray,saatlerArray)
}


var (gunArray,saatArray) = parcala(gelenString: gelenString)

for i in 0..<gunArray.count{
    if let tempGun = gunDic[gunArray[i]], let tempSaat = saatDic[saatArray[i]] {
        print(tempGun," Günü, ", tempSaat, "Saati Dolu")
    }
    
}
