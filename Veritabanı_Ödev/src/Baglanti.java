
import java.sql.*;
import java.util.Scanner;

public class Baglanti {


    private Connection baglan() throws SQLException {
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/arac_satma",
                "postgres", "12345");
        if (conn != null)
            System.out.println("Veritabanına bağlandı!");
        else
            System.out.println("Bağlantı girişimi başarısız!");

        return conn;
    }

    public void aracAraGoruntule(int secim) throws SQLException {

        Connection conn = baglan();

        String sql="";

        if (secim == 1)
        {
            sql= "SELECT * FROM satilik_araclar INNER JOIN arac_modelleri " +
                    "ON satilik_araclar.model_no = arac_modelleri.model_no " +
                    "INNER JOIN arac_kategorileri ON satilik_araclar.kategori_no = arac_kategorileri.kategori_no " +
                    "INNER JOIN ureticiler ON satilik_araclar.uretici_id = ureticiler.uretici_id";
        }

        else
        {
            System.out.println("Aramak istediginiz arac no");
            Scanner sc = new Scanner(System.in);
            String aranacak = sc.next();
            sql= "SELECT * FROM satilik_araclar INNER JOIN arac_modelleri " +
                    "ON satilik_araclar.model_no = arac_modelleri.model_no " +
                    "INNER JOIN arac_kategorileri ON satilik_araclar.kategori_no = arac_kategorileri.kategori_no " +
                    "INNER JOIN ureticiler ON satilik_araclar.uretici_id = ureticiler.uretici_id WHERE arac_id = "+ aranacak;
        }




        /*** Sorgu çalıştırma ***/
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);


        /*** Bağlantı sonlandırma ***/
        conn.close();

        System.out.println("\tarac_id " + " \turetici " + " \tmodel "
                + " \t\tfiyat " + " \t\t\tkilometre "
                + " \t\tyil " + " \t\tkategori ");

        while(rs.next())
        {

            int arac_id = rs.getInt("arac_id");
            String uretici = rs.getString("uretici_adi");
            String model = rs.getString("model_ismi");
            double fiyat = rs.getDouble("fiyat");
            String kategori = rs.getString("kategori_ismi");
            int kilometre = rs.getInt("kilometre");
            int yil = rs.getInt("yil");


            System.out.println(" \t" + arac_id + " \t\t\t" + uretici +
                    " \t\t" + model + " \t\t" + fiyat + " \t\t" + kilometre +
                    " \t\t\t" + yil + " \t\t" + kategori);
        }

        rs.close();
        stmt.close();

    }

    public String ozellikSec() throws  SQLException{
        Scanner sc = new Scanner(System.in);
        String degisecek="";
        int islem = 0;
        while(islem !=4)
        {
            System.out.println("\nYapmak istediginiz islemi seciniz :");
            System.out.println("1- Fiyat Guncelle");
            System.out.println("2- Kilometre Guncelle");
            System.out.println("3- Yil Guncelle");
            System.out.println("4- Cikis");

            islem = sc.nextInt();
            switch (islem)
            {
                case 1:
                    degisecek = "fiyat";
                    break;

                case 2:
                    degisecek = "kilometre";
                    break;

                case 3:
                    degisecek = "yil";
                    break;

                case 4:
                    break;

            }
            return degisecek;
        }
        return degisecek;
    }

    public void aracGuncelle(String degisecek) throws SQLException {

        String arac_id, degisecek_sutun, yeni_deger;
        System.out.println("Kac nolu aracla islem yapmak istiyorsunuz?");
        Scanner sc = new Scanner(System.in);
        arac_id = sc.next();

        degisecek_sutun = degisecek;
        System.out.println("Yeni Deger Giriniz: ");
        yeni_deger = sc.next();

        Connection conn = baglan();

        String sql= "UPDATE satilik_araclar SET " +degisecek_sutun+ " = " +yeni_deger+ " WHERE arac_id = " +arac_id;



        Statement stmt = conn.createStatement();
        int sonuc = stmt.executeUpdate(sql);

        if(sonuc == 1)
            System.out.println("Güncelleme basarili");
        else
            System.out.println("islem basarisiz oldu");


        conn.close();
        stmt.close();

    }


    public void aracSil() throws SQLException {

        String arac_id;
        System.out.println("Kac nolu araci silmek istiyorsunuz?");

        Scanner sc = new Scanner(System.in);
        arac_id = sc.next();

        Connection conn = baglan();

        String sql= "DELETE FROM satilik_araclar WHERE arac_id = " +arac_id;


        /*** Sorgu çalıştırma ***/
        Statement stmt = conn.createStatement();
        int sonuc = stmt.executeUpdate(sql);

        if(sonuc == 1)
            System.out.println("Güncelleme basarili");
        else
            System.out.println("islem basarisiz oldu");

        /*** Bağlantı sonlandırma ***/
        conn.close();

        /*** Kaynakları serbest bırak ***/
        stmt.close();

    }

    public void aracEkle() throws SQLException {

        String  uretici_id,model_no,kategori_no,fiyat,kilometre,yil;
        Scanner sc = new Scanner(System.in);

        System.out.println("uretici id giriniz");
        uretici_id = sc.next();

        System.out.println("model no giriniz");
        model_no = sc.next();

        System.out.println("kategori no giriniz");
        kategori_no = sc.next();

        System.out.println("fiyat giriniz");
        fiyat = sc.next();

        System.out.println("kilometre giriniz");
        kilometre = sc.next();

        System.out.println("yil giriniz");
        yil = sc.next();

        Connection conn = baglan();

        String sql= "INSERT INTO satilik_araclar (uretici_id,model_no,kategori_no,fiyat,kilometre,yil)" +
                "VALUES ("+uretici_id+","+model_no+","+kategori_no+","+fiyat+","+kilometre+","+yil+")";


        /*** Sorgu çalıştırma ***/
        Statement stmt = conn.createStatement();
        int sonuc = stmt.executeUpdate(sql);

        if(sonuc == 1)
            System.out.println("Güncelleme basarili");
        else
            System.out.println("islem basarisiz oldu");

        /*** Bağlantı sonlandırma ***/
        conn.close();

        /*** Kaynakları serbest bırak ***/
        stmt.close();

    }

    public void satisEkle() throws SQLException {

        String  arac_id,musteri_id,satilan_fiyat,satilma_tarihi;
        Scanner sc = new Scanner(System.in);

        System.out.println("arac id giriniz");
        arac_id = sc.next();

        System.out.println("musteri id giriniz");
        musteri_id = sc.next();

        System.out.println("satilan fiyati giriniz");
        satilan_fiyat = sc.next();



        Connection conn = baglan();

        String sql= "INSERT INTO satilmis_araclar (arac_id, musteri_id, satilan_fiyat)" +
                "VALUES ("+arac_id+","+musteri_id+","+satilan_fiyat+")";


        /*** Sorgu çalıştırma ***/
        Statement stmt = conn.createStatement();
        int sonuc = stmt.executeUpdate(sql);

        if(sonuc == 1)
            System.out.println("Güncelleme basarili");
        else
            System.out.println("islem basarisiz oldu");


        /*** Bağlantı sonlandırma ***/
        conn.close();

        /*** Kaynakları serbest bırak ***/
        stmt.close();

    }



}
