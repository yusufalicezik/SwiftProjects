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

//
//let gunDic=["1":"Pazartesi","2":"Salı","3":"Çarşamba"] //...4,5,6...
//
//let saatDic=["1":"08:00","2":"09:00","3":"10:00","4":"11:00"] //...5,6,7...
//
//
//
//var gelenString="1-2,2-4,1-3,2-3"
//
//
//func parcala(gelenString:String)->([String],[String]){
//
//    var gunlerArray=[String]()
//    var saatlerArray=[String]()
//
//    let ilkAyrilmisDizi=gelenString.split(separator: ",") //1-2   1-4  ....
//    for i in 0..<ilkAyrilmisDizi.count {
//       let ikinciAyrilmisDizi = ilkAyrilmisDizi[i].split(separator: "-") // 1  2
//       gunlerArray.append(String(ikinciAyrilmisDizi[0])) // 1 -) pazartesi     1-) Pazartesi
//        saatlerArray.append(String(ikinciAyrilmisDizi[1])) // 2 -) saat 09:00    4-) Saat 11:00
//    }
//    return (gunlerArray,saatlerArray)
//}
//
//
//var (gunArray,saatArray) = parcala(gelenString: gelenString)
//
//for i in 0..<gunArray.count{
//    if let tempGun = gunDic[gunArray[i]], let tempSaat = saatDic[saatArray[i]] {
//        print(tempGun," Günü, ", tempSaat, "Saati Dolu")
//    }
//
//}
//----------------------------------------------------//----------------------------------------------------

//var denemeClousere : (Int,Int)->Int  = {$0 + $1}
//
//denemeClousere(1,4)
//
//
//var kareAlmaClousure : (Int) ->Int = { //değişkene atar gibi yaptık, ilk önce türünü daha sonra türünün doldurulmuşunu yazarız -> yerine de in
//   $0*$0
//}
//
//print(kareAlmaClousure(8))
//----------------------------------------------------//----------------------------------------------------

//
//var dizi = Array(1...100).filter( {$0 % 2 == 0} )
//print(dizi)
//
//----------------------------------------------------//----------------------------------------------------

//5 ‘ e Bölünebilen Sayıları Filtreleyen Closure, 2 ye bölünebilen closure, 10 dan küçükleri filtreleyen vs..

//var dizi=[1,4,5,12,15,19,20,30,25,6,78,95]
//
//func closureFiltreleme(closure:(Int)->Bool, dizi:[Int])->[Int]{
//    var filtreliDizi=[Int]()
//    for i in dizi{
//        if closure(i){
//            filtreliDizi.append(i)
//        }
//    }
//    return filtreliDizi
//}
//
//closureFiltreleme(closure: { (sayi:Int) -> Bool in
//    sayi % 5 == 0
//},dizi:dizi)
//
//
//
//closureFiltreleme(closure: { (sayi:Int) -> Bool in
//    sayi < 10
//}, dizi: dizi)
//
////closure filtreleme adlı fonksiyonu istediğimiz kadar kullanabiliriz bu şekilde farklı farklı olarak..
////gönderirken işlevi yazarız ve daha temiz kod olur.
//
//
//
//----------------------------------------------------//----------------------------------------------------
//
//var dizi = [Int]()
//var dizi2 : Array<Int> = [2,3,4]
//dizi2.append(3)
//
//print(Set(dizi2))
//----------------------------------------------------//----------------------------------------------------

//
//protocol MyDataDelegate{
//    func veriGonder(string:String)
//}
//
//class FirstVC{
//    var delegate:MyDataDelegate?
//
//}
//
//class SecondVC:MyDataDelegate{
//
//
//
//    func veriGonder(string: String) {
//        print("veri geldi..\(string)")
//    }
//
//
//}
//var firstVc = FirstVC()
//firstVc.delegate = SecondVC()
//
//firstVc.delegate?.veriGonder(string: "sa")

//----------------------------------------------------//----------------------------------------------------



//var kisaClosure : (Int,Int)->Int = {
//    (sayi1:Int,sayi2:Int) in
//        return sayi1+sayi2
//
//}
//
//kisaClosure(1,3)
//
//
//func deneme(closure: (Int)->Bool, sayi:Int){
//    if closure(sayi){
//        print("true")
//    }
//}
//
//deneme(closure: { (sayi) -> Bool in
//    return sayi > 0
//}, sayi: 0)
//----------------------------------------------------//----------------------------------------------------


//ENUM

//normel enum
//enum Gezegenler {
//    case Dunya,Mars,Neptun
//}
//
//let gezegen = Gezegenler.Dunya
//
//switch gezegen {
//case .Dunya:
//        print("gezegen dünyadır")
//case .Mars :
//        print("gezegen marstır")
//default:
//    print("tanımsız gezegen")
//}
//
//
//----------------------------------------------------//----------------------------------------------------

//enum-String-rawvalue

//enum Gezegenler:String {
//    case Dunya
//    case Mars
//    case Neptun
//}
//
//let gezegen = Gezegenler.Dunya.rawValue // : String ekleyince rawvalue gelir ve o da toString gibidir. gezegeni string e dönüştürür(alt yapıp üstüne bakınca görürüz.)
//

//----------------------------------------------------//----------------------------------------------------


//enum Gezegenler:String {
//    case Dunya = "Yaşam var"
//    case Mars = "Kızıl gezegen"
//    case Neptun = "non"
//}
//
//let gezegen = Gezegenler.Dunya.rawValue // : String ekleyince rawvalue gelir ve o da toString gibidir. gezegeni string e dönüştürür(alt yapıp üstüne bakınca görürüz.)
//print(gezegen) //eğer bir değer var ise onu yazdırır. çıktı : yaşam var..
//----------------------------------------------------//----------------------------------------------------


//enum Not : String {
//    case Doksan = "AA"
//    case Seksen = "BA"
//    case Yetmiş = "BB"
//
//    var tanim : String {
//        return self.rawValue
//    }
//
//
//}
//
//var not = Not.Doksan.tanim
//
//
//
//----------------------------------------------------//----------------------------------------------------

//enum Renkler : String {
//    case Success
//    case Danger
//
//    var renkGetir : UIColor {
//        switch self {
//        case .Danger:
//            return UIColor.red
//        default:
//            return UIColor.white
//        }
//    }
//}
//
//var renk = Renkler.Danger.renkGetir


//----------------------------------------------------//----------------------------------------------------

class UyariMesaji {
    
    enum MesajTuru : String{
        case BasitUyari
        case CiddiUyari
    }
    enum MesajButonTuru : String{
        case TamamButon
        case IleriButon
    }
    enum MesajRengi : String{
        case Kirmizi
        case Sari
        case Yesil
    }
    var mesajTuru : MesajTuru
    var mesajButonTuru : MesajButonTuru
    var mesajRengi : MesajRengi
    
    init(_ mesajTuru:MesajTuru, _ mesajButonTuru:MesajButonTuru, _ mesajRengi:MesajRengi) {
        self.mesajTuru=mesajTuru
        self.mesajRengi=mesajRengi
        self.mesajButonTuru=mesajButonTuru
    }
    
    func mesajiGoster(){
        print(self.mesajButonTuru.rawValue + " / " + self.mesajTuru.rawValue + " / " + self.mesajRengi.rawValue)
    }
    
}

var myAlert = UyariMesaji(.BasitUyari, .TamamButon, .Yesil)

myAlert.mesajiGoster()
