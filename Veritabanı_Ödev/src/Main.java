
import java.sql.SQLException;
import java.util.Scanner;

public class Main {


    public static void main(String[] args) throws SQLException {

        Baglanti baglan = new Baglanti();

        System.out.println("Arac satis uygulamasina hosgeldiniz");

        int secim = 0;
        int adminsecim = 0;
        Scanner sc = new Scanner(System.in);

        while(secim != 3)
        {
            System.out.println("\nYapmak istediginiz islemi seciniz :");
            System.out.println("1- Araclari ara veya goruntule");
            System.out.println("2- Giris Yap");
            System.out.println("3- Cikis Yap");

            secim = sc.nextInt();
            switch (secim) {

                case 1:
                    int karar = 0;
                    System.out.println("Tum araclari goruntulemek icin 1 e basin");
                    System.out.println("Arac aramak icin 2 ye basin");
                    karar = sc.nextInt();
                    baglan.aracAraGoruntule(karar);
                    break;

                case 2:

                    adminsecim = 0;
                    while(adminsecim !=6)
                    {
                        System.out.println("\nYapmak istediginiz islemi seciniz :");
                        System.out.println("1- Araclari listele");
                        System.out.println("2- Arac ekle");
                        System.out.println("3- Arac guncelle");
                        System.out.println("4- Arac sil");
                        System.out.println("5- Satis ekle");
                        System.out.println("6- Menuye don");

                        adminsecim = sc.nextInt();
                        switch (adminsecim)
                        {
                            case 1:
                                baglan.aracAraGoruntule(1);
                                break;

                            case 2:
                                baglan.aracEkle();
                                break;

                            case 3:
                                String degistir = baglan.ozellikSec();
                                baglan.aracGuncelle(degistir);
                                break;
                            case 4:
                                baglan.aracSil();
                                break;

                            case 5:
                                baglan.satisEkle();
                                break;

                            case 6:
                                break;

                        }
                    }
                case 3:
                	if(secim==3)
                    System.out.println("Çýkýþ Yapýldý");
                    break;
                    
            }
        }


    }
}
