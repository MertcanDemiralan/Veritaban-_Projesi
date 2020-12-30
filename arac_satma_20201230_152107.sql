--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: aracara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.aracara(aranacak integer) RETURNS TABLE(aracid integer, kategorino integer)
    LANGUAGE plpgsql
    AS $$ BEGIN     RETURN QUERY SELECT "arac_id", "kategori_no" FROM satilik_araclar                  WHERE "arac_id" = aranacak; END; $$;


ALTER FUNCTION public.aracara(aranacak integer) OWNER TO postgres;

--
-- Name: finans_sirket_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.finans_sirket_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN          DELETE FROM sirketler 
         WHERE sirket_id = OLD.sirket_id;       RETURN NEW; END; $$;


ALTER FUNCTION public.finans_sirket_sil() OWNER TO postgres;

--
-- Name: musteri_adres_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musteri_adres_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN          DELETE FROM adresler          WHERE adres_id = OLD.adres_id;       RETURN NEW; END; $$;


ALTER FUNCTION public.musteri_adres_sil() OWNER TO postgres;

--
-- Name: sigorta_police_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sigorta_police_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN          DELETE FROM sirketler          WHERE id = OLD.id;       RETURN NEW; END; $$;


ALTER FUNCTION public.sigorta_police_sil() OWNER TO postgres;

--
-- Name: sigorta_sirket_sil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sigorta_sirket_sil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN          DELETE FROM sirketler          WHERE sirket_id = OLD.sirket_id;       RETURN NEW; END; $$;


ALTER FUNCTION public.sigorta_sirket_sil() OWNER TO postgres;

--
-- Name: sigortaara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sigortaara(aranacak integer) RETURNS TABLE(idd integer, satisidd integer)
    LANGUAGE plpgsql
    AS $$ BEGIN     RETURN QUERY SELECT "id", "satis_id" FROM sigorta_policeleri                  WHERE "id" = aranacak; END; $$;


ALTER FUNCTION public.sigortaara(aranacak integer) OWNER TO postgres;

--
-- Name: tumaraclar(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tumaraclar() RETURNS TABLE(aracid integer, kategorino integer)
    LANGUAGE plpgsql
    AS $$ BEGIN     RETURN QUERY SELECT "arac_id", "kategori_no" FROM satilik_araclar; END; $$;


ALTER FUNCTION public.tumaraclar() OWNER TO postgres;

--
-- Name: tumsigorta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tumsigorta() RETURNS TABLE(idd integer, satisidd integer)
    LANGUAGE plpgsql
    AS $$ BEGIN 
    RETURN QUERY SELECT "id", "satis_id" FROM sigorta_policeleri; END; $$;


ALTER FUNCTION public.tumsigorta() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adresler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adresler (
    id integer NOT NULL,
    musteri_id integer NOT NULL,
    adres_aciklama character varying NOT NULL,
    ulke character varying NOT NULL,
    il character varying NOT NULL,
    ilce character varying NOT NULL,
    posta_kodu character varying NOT NULL
);


ALTER TABLE public.adresler OWNER TO postgres;

--
-- Name: adresler2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adresler2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adresler2_id_seq OWNER TO postgres;

--
-- Name: adresler2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adresler2_id_seq OWNED BY public.adresler.id;


--
-- Name: arac_ek_ozellikleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arac_ek_ozellikleri (
    ozellik_id integer NOT NULL,
    ozellik_aciklamasi character varying NOT NULL
);


ALTER TABLE public.arac_ek_ozellikleri OWNER TO postgres;

--
-- Name: arac_ek_ozellikleri2_ozellik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arac_ek_ozellikleri2_ozellik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arac_ek_ozellikleri2_ozellik_id_seq OWNER TO postgres;

--
-- Name: arac_ek_ozellikleri2_ozellik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arac_ek_ozellikleri2_ozellik_id_seq OWNED BY public.arac_ek_ozellikleri.ozellik_id;


--
-- Name: arac_kategorileri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arac_kategorileri (
    kategori_no integer NOT NULL,
    kategori_ismi character varying NOT NULL
);


ALTER TABLE public.arac_kategorileri OWNER TO postgres;

--
-- Name: arac_kategorileri2_kategori_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arac_kategorileri2_kategori_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arac_kategorileri2_kategori_no_seq OWNER TO postgres;

--
-- Name: arac_kategorileri2_kategori_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arac_kategorileri2_kategori_no_seq OWNED BY public.arac_kategorileri.kategori_no;


--
-- Name: arac_kredisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arac_kredisi (
    kredi_id integer NOT NULL,
    satis_id integer NOT NULL,
    finans_sirket_id integer NOT NULL,
    aylik_odeme money NOT NULL,
    geri_odeme_baslangic date NOT NULL,
    geri_odeme_bitis date NOT NULL
);


ALTER TABLE public.arac_kredisi OWNER TO postgres;

--
-- Name: arac_kredisi2_kredi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arac_kredisi2_kredi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arac_kredisi2_kredi_id_seq OWNER TO postgres;

--
-- Name: arac_kredisi2_kredi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arac_kredisi2_kredi_id_seq OWNED BY public.arac_kredisi.kredi_id;


--
-- Name: arac_modelleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arac_modelleri (
    model_no integer NOT NULL,
    uretici_no integer NOT NULL,
    model_ismi character varying NOT NULL
);


ALTER TABLE public.arac_modelleri OWNER TO postgres;

--
-- Name: arac_modelleri2_model_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arac_modelleri2_model_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arac_modelleri2_model_no_seq OWNER TO postgres;

--
-- Name: arac_modelleri2_model_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arac_modelleri2_model_no_seq OWNED BY public.arac_modelleri.model_no;


--
-- Name: finans_sirketleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finans_sirketleri (
    sirket_id integer NOT NULL,
    faiz_oranlari character varying NOT NULL
);


ALTER TABLE public.finans_sirketleri OWNER TO postgres;

--
-- Name: finans_sirketleri2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finans_sirketleri2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finans_sirketleri2_id_seq OWNER TO postgres;

--
-- Name: finans_sirketleri2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finans_sirketleri2_id_seq OWNED BY public.finans_sirketleri.sirket_id;


--
-- Name: musteri_odemeleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri_odemeleri (
    id integer NOT NULL,
    satis_id integer NOT NULL,
    musteri_id integer NOT NULL,
    odeme_durum_no integer NOT NULL,
    odenen_tutar money NOT NULL
);


ALTER TABLE public.musteri_odemeleri OWNER TO postgres;

--
-- Name: musteri_odemeleri2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_odemeleri2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_odemeleri2_id_seq OWNER TO postgres;

--
-- Name: musteri_odemeleri2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_odemeleri2_id_seq OWNED BY public.musteri_odemeleri.id;


--
-- Name: musteri_tercihleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri_tercihleri (
    id integer NOT NULL,
    ozellik_id integer NOT NULL,
    musteri_id integer NOT NULL
);


ALTER TABLE public.musteri_tercihleri OWNER TO postgres;

--
-- Name: musteri_tercihleri2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_tercihleri2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_tercihleri2_id_seq OWNER TO postgres;

--
-- Name: musteri_tercihleri2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_tercihleri2_id_seq OWNED BY public.musteri_tercihleri.id;


--
-- Name: musteriler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteriler (
    musteri_id integer NOT NULL,
    telefon_no character varying NOT NULL,
    email_adresi character varying NOT NULL,
    ad character varying NOT NULL,
    soyad character varying NOT NULL,
    kullanici_adi character varying NOT NULL,
    sifre character varying NOT NULL
);


ALTER TABLE public.musteriler OWNER TO postgres;

--
-- Name: musteriler2_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteriler2_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteriler2_musteri_id_seq OWNER TO postgres;

--
-- Name: musteriler2_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteriler2_musteri_id_seq OWNED BY public.musteriler.musteri_id;


--
-- Name: odeme_durum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odeme_durum (
    odeme_durum_no integer NOT NULL,
    durum_aciklamasi character varying NOT NULL
);


ALTER TABLE public.odeme_durum OWNER TO postgres;

--
-- Name: odeme_durum2_odeme_durum_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.odeme_durum2_odeme_durum_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.odeme_durum2_odeme_durum_no_seq OWNER TO postgres;

--
-- Name: odeme_durum2_odeme_durum_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.odeme_durum2_odeme_durum_no_seq OWNED BY public.odeme_durum.odeme_durum_no;


--
-- Name: satilik_arac_ek_ozellikleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satilik_arac_ek_ozellikleri (
    arac_id integer NOT NULL,
    ozellik_id integer NOT NULL
);


ALTER TABLE public.satilik_arac_ek_ozellikleri OWNER TO postgres;

--
-- Name: satilik_araclar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satilik_araclar (
    arac_id integer NOT NULL,
    uretici_id integer NOT NULL,
    model_no integer NOT NULL,
    kategori_no integer NOT NULL,
    fiyat numeric NOT NULL,
    kilometre integer NOT NULL,
    yil integer NOT NULL
);


ALTER TABLE public.satilik_araclar OWNER TO postgres;

--
-- Name: satilik_araclar2_arac_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satilik_araclar2_arac_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satilik_araclar2_arac_id_seq OWNER TO postgres;

--
-- Name: satilik_araclar2_arac_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satilik_araclar2_arac_id_seq OWNED BY public.satilik_araclar.arac_id;


--
-- Name: satilmis_araclar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satilmis_araclar (
    satis_id integer NOT NULL,
    arac_id integer NOT NULL,
    musteri_id integer NOT NULL,
    satilan_fiyat numeric NOT NULL,
    satilma_tarihi date DEFAULT now() NOT NULL
);


ALTER TABLE public.satilmis_araclar OWNER TO postgres;

--
-- Name: satilmis_araclar2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.satilmis_araclar2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satilmis_araclar2_id_seq OWNER TO postgres;

--
-- Name: satilmis_araclar2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.satilmis_araclar2_id_seq OWNED BY public.satilmis_araclar.satis_id;


--
-- Name: sigorta_policeleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sigorta_policeleri (
    id integer NOT NULL,
    satis_id integer NOT NULL,
    sigorta_sirket_id integer NOT NULL,
    aylik_odeme money NOT NULL,
    sigorta_yenileme_tarihi date NOT NULL,
    sigorta_baslangic_tarihi date NOT NULL
);


ALTER TABLE public.sigorta_policeleri OWNER TO postgres;

--
-- Name: sigorta_policeleri2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sigorta_policeleri2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sigorta_policeleri2_id_seq OWNER TO postgres;

--
-- Name: sigorta_policeleri2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sigorta_policeleri2_id_seq OWNED BY public.sigorta_policeleri.id;


--
-- Name: sigorta_sirketleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sigorta_sirketleri (
    sirket_id integer NOT NULL,
    kacyil character varying NOT NULL
);


ALTER TABLE public.sigorta_sirketleri OWNER TO postgres;

--
-- Name: sigorta_sirketleri2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sigorta_sirketleri2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sigorta_sirketleri2_id_seq OWNER TO postgres;

--
-- Name: sigorta_sirketleri2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sigorta_sirketleri2_id_seq OWNED BY public.sigorta_sirketleri.sirket_id;


--
-- Name: sirketler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sirketler (
    sirket_id integer NOT NULL,
    sirket_adi character varying NOT NULL
);


ALTER TABLE public.sirketler OWNER TO postgres;

--
-- Name: ureticiler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ureticiler (
    uretici_id integer NOT NULL,
    uretici_adi character varying NOT NULL
);


ALTER TABLE public.ureticiler OWNER TO postgres;

--
-- Name: ureticiler2_ureticii_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ureticiler2_ureticii_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ureticiler2_ureticii_id_seq OWNER TO postgres;

--
-- Name: ureticiler2_ureticii_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ureticiler2_ureticii_id_seq OWNED BY public.ureticiler.uretici_id;


--
-- Name: adresler id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adresler ALTER COLUMN id SET DEFAULT nextval('public.adresler2_id_seq'::regclass);


--
-- Name: arac_ek_ozellikleri ozellik_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_ek_ozellikleri ALTER COLUMN ozellik_id SET DEFAULT nextval('public.arac_ek_ozellikleri2_ozellik_id_seq'::regclass);


--
-- Name: arac_kategorileri kategori_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kategorileri ALTER COLUMN kategori_no SET DEFAULT nextval('public.arac_kategorileri2_kategori_no_seq'::regclass);


--
-- Name: arac_kredisi kredi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kredisi ALTER COLUMN kredi_id SET DEFAULT nextval('public.arac_kredisi2_kredi_id_seq'::regclass);


--
-- Name: arac_modelleri model_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_modelleri ALTER COLUMN model_no SET DEFAULT nextval('public.arac_modelleri2_model_no_seq'::regclass);


--
-- Name: finans_sirketleri sirket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finans_sirketleri ALTER COLUMN sirket_id SET DEFAULT nextval('public.finans_sirketleri2_id_seq'::regclass);


--
-- Name: musteri_odemeleri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_odemeleri ALTER COLUMN id SET DEFAULT nextval('public.musteri_odemeleri2_id_seq'::regclass);


--
-- Name: musteri_tercihleri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_tercihleri ALTER COLUMN id SET DEFAULT nextval('public.musteri_tercihleri2_id_seq'::regclass);


--
-- Name: musteriler musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteriler2_musteri_id_seq'::regclass);


--
-- Name: odeme_durum odeme_durum_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme_durum ALTER COLUMN odeme_durum_no SET DEFAULT nextval('public.odeme_durum2_odeme_durum_no_seq'::regclass);


--
-- Name: satilik_araclar arac_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_araclar ALTER COLUMN arac_id SET DEFAULT nextval('public.satilik_araclar2_arac_id_seq'::regclass);


--
-- Name: satilmis_araclar satis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilmis_araclar ALTER COLUMN satis_id SET DEFAULT nextval('public.satilmis_araclar2_id_seq'::regclass);


--
-- Name: sigorta_policeleri id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_policeleri ALTER COLUMN id SET DEFAULT nextval('public.sigorta_policeleri2_id_seq'::regclass);


--
-- Name: sigorta_sirketleri sirket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_sirketleri ALTER COLUMN sirket_id SET DEFAULT nextval('public.sigorta_sirketleri2_id_seq'::regclass);


--
-- Name: ureticiler uretici_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ureticiler ALTER COLUMN uretici_id SET DEFAULT nextval('public.ureticiler2_ureticii_id_seq'::regclass);


--
-- Data for Name: adresler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.adresler VALUES
	(1, 2, 'A mahallesi', 'Turkiye', 'Istanbul', 'Kadikoy', '34526'),
	(2, 1, 'D mahallesi', 'Turkiye', 'Istanbul', 'Bakirkoy', '34157'),
	(4, 3, 'X Mahallesi', 'Turkiye', 'Ankara', 'Kizilay', '06412');


--
-- Data for Name: arac_ek_ozellikleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arac_ek_ozellikleri VALUES
	(1, 'sunroof'),
	(3, 'hava yastiklari'),
	(2, 'elektrikli aynalar'),
	(4, 'cam tavan');


--
-- Data for Name: arac_kategorileri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arac_kategorileri VALUES
	(1, 'Sedan'),
	(4, 'SUV 4x2'),
	(5, 'SUV 4x4'),
	(2, 'HB 5 kapi'),
	(3, 'HB 3 kapi'),
	(6, 'Coupe'),
	(7, 'Cabrio');


--
-- Data for Name: arac_kredisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arac_kredisi VALUES
	(1, 2, 1, '?1.000,00', '2020-01-01', '2021-01-01'),
	(2, 3, 1, '?6.000,00', '2020-08-18', '2023-05-06');


--
-- Data for Name: arac_modelleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arac_modelleri VALUES
	(2, 2, 'Focus'),
	(1, 1, '320d'),
	(3, 1, '330i'),
	(4, 4, 'Jazz'),
	(5, 3, 'S40');


--
-- Data for Name: finans_sirketleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.finans_sirketleri VALUES
	(1, '50'),
	(2, '60'),
	(3, '78'),
	(4, '90');


--
-- Data for Name: musteri_odemeleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri_odemeleri VALUES
	(1, 1, 2, 1, '?20.000,00');


--
-- Data for Name: musteri_tercihleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri_tercihleri VALUES
	(1, 2, 2),
	(2, 1, 3),
	(3, 2, 1);


--
-- Data for Name: musteriler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteriler VALUES
	(1, '5513642456', 'musteri1@gmail.com', 'isim1', 'soyad1', 'kadi123', 'sifre123'),
	(3, '5541231256', 'musteri3@gmail.com', 'isim3', 'soyad3', 'kadi12345', 'sifre12345'),
	(2, '5578946585', 'musteri2@gmail.com', 'isim2', 'soyad2', 'kadi1234', 'sifre1234');


--
-- Data for Name: odeme_durum; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.odeme_durum VALUES
	(1, 'Onay'),
	(2, 'Bekleme'),
	(3, 'Geçici');


--
-- Data for Name: satilik_arac_ek_ozellikleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.satilik_arac_ek_ozellikleri VALUES
	(1, 1),
	(2, 1),
	(3, 2);


--
-- Data for Name: satilik_araclar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.satilik_araclar VALUES
	(3, 3, 5, 2, 350000.00, 54000, 2020),
	(4, 1, 1, 3, 250000, 150040, 2015),
	(5, 1, 2, 1, 200000, 20030, 2009),
	(2, 2, 1, 1, 200000, 200000, 2019),
	(1, 1, 2, 2, 200000, 330000, 2019);


--
-- Data for Name: satilmis_araclar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.satilmis_araclar VALUES
	(1, 2, 1, 250000.00, '2020-01-20'),
	(2, 1, 2, 350000.00, '2020-07-30'),
	(3, 3, 2, 350000, '2020-08-09'),
	(8, 5, 2, 230000, '2020-12-30'),
	(9, 2, 1, 550000, '2020-12-30');


--
-- Data for Name: sigorta_policeleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sigorta_policeleri VALUES
	(1, 1, 2, '?1.000,00', '2023-01-01', '2021-01-04'),
	(2, 2, 1, '?1.400,00', '2024-03-25', '2020-03-27');


--
-- Data for Name: sigorta_sirketleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sigorta_sirketleri VALUES
	(1, '35'),
	(2, '50'),
	(3, '20'),
	(4, '14'),
	(5, '10');


--
-- Data for Name: sirketler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sirketler VALUES
	(2, 'Sirket2'),
	(3, 'Sirket3'),
	(4, 'Sirket4'),
	(5, 'Sirket5'),
	(1, 'Sirket1');


--
-- Data for Name: ureticiler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ureticiler VALUES
	(1, 'Ford'),
	(2, 'BMW'),
	(4, 'Honda'),
	(3, 'Volvo');


--
-- Name: adresler2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adresler2_id_seq', 4, true);


--
-- Name: arac_ek_ozellikleri2_ozellik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arac_ek_ozellikleri2_ozellik_id_seq', 3, true);


--
-- Name: arac_kategorileri2_kategori_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arac_kategorileri2_kategori_no_seq', 7, true);


--
-- Name: arac_kredisi2_kredi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arac_kredisi2_kredi_id_seq', 1, false);


--
-- Name: arac_modelleri2_model_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arac_modelleri2_model_no_seq', 5, true);


--
-- Name: finans_sirketleri2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finans_sirketleri2_id_seq', 4, true);


--
-- Name: musteri_odemeleri2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_odemeleri2_id_seq', 1, false);


--
-- Name: musteri_tercihleri2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_tercihleri2_id_seq', 3, true);


--
-- Name: musteriler2_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteriler2_musteri_id_seq', 3, true);


--
-- Name: odeme_durum2_odeme_durum_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odeme_durum2_odeme_durum_no_seq', 3, true);


--
-- Name: satilik_araclar2_arac_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satilik_araclar2_arac_id_seq', 16, true);


--
-- Name: satilmis_araclar2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.satilmis_araclar2_id_seq', 9, true);


--
-- Name: sigorta_policeleri2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sigorta_policeleri2_id_seq', 6, true);


--
-- Name: sigorta_sirketleri2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sigorta_sirketleri2_id_seq', 5, true);


--
-- Name: ureticiler2_ureticii_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ureticiler2_ureticii_id_seq', 4, true);


--
-- Name: adresler adresler2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adresler
    ADD CONSTRAINT adresler2_pkey PRIMARY KEY (id);


--
-- Name: arac_ek_ozellikleri arac_ek_ozellikleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_ek_ozellikleri
    ADD CONSTRAINT arac_ek_ozellikleri2_pkey PRIMARY KEY (ozellik_id);


--
-- Name: arac_kategorileri arac_kategorileri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kategorileri
    ADD CONSTRAINT arac_kategorileri2_pkey PRIMARY KEY (kategori_no);


--
-- Name: arac_kredisi arac_kredisi2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kredisi
    ADD CONSTRAINT arac_kredisi2_pkey PRIMARY KEY (kredi_id);


--
-- Name: arac_modelleri arac_modelleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_modelleri
    ADD CONSTRAINT arac_modelleri2_pkey PRIMARY KEY (model_no);


--
-- Name: finans_sirketleri finans_sirketleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finans_sirketleri
    ADD CONSTRAINT finans_sirketleri2_pkey PRIMARY KEY (sirket_id);


--
-- Name: musteri_odemeleri musteri_odemeleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_odemeleri
    ADD CONSTRAINT musteri_odemeleri2_pkey PRIMARY KEY (id);


--
-- Name: musteri_tercihleri musteri_tercihleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_tercihleri
    ADD CONSTRAINT musteri_tercihleri2_pkey PRIMARY KEY (id);


--
-- Name: musteriler musteriler2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteriler
    ADD CONSTRAINT musteriler2_pkey PRIMARY KEY (musteri_id);


--
-- Name: odeme_durum odeme_durum2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme_durum
    ADD CONSTRAINT odeme_durum2_pkey PRIMARY KEY (odeme_durum_no);


--
-- Name: satilik_arac_ek_ozellikleri satilik_arac_ozellikleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_arac_ek_ozellikleri
    ADD CONSTRAINT satilik_arac_ozellikleri_pkey PRIMARY KEY (arac_id, ozellik_id);


--
-- Name: satilik_araclar satilik_araclar2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_araclar
    ADD CONSTRAINT satilik_araclar2_pkey PRIMARY KEY (arac_id);


--
-- Name: satilmis_araclar satilmis_araclar2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilmis_araclar
    ADD CONSTRAINT satilmis_araclar2_pkey PRIMARY KEY (satis_id);


--
-- Name: sigorta_policeleri sigorta_policeleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_policeleri
    ADD CONSTRAINT sigorta_policeleri2_pkey PRIMARY KEY (id);


--
-- Name: sigorta_sirketleri sigorta_sirketleri2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_sirketleri
    ADD CONSTRAINT sigorta_sirketleri2_pkey PRIMARY KEY (sirket_id);


--
-- Name: sirketler sirketler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sirketler
    ADD CONSTRAINT sirketler_pkey PRIMARY KEY (sirket_id);


--
-- Name: ureticiler ureticiler2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ureticiler
    ADD CONSTRAINT ureticiler2_pkey PRIMARY KEY (uretici_id);


--
-- Name: finans_sirketleri finans_sirket_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER finans_sirket_trigger AFTER DELETE ON public.finans_sirketleri FOR EACH ROW EXECUTE FUNCTION public.finans_sirket_sil();


--
-- Name: musteriler musteri_adres_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER musteri_adres_trigger AFTER DELETE ON public.musteriler FOR EACH ROW EXECUTE FUNCTION public.musteri_adres_sil();


--
-- Name: sigorta_sirketleri sigorta_police_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sigorta_police_trigger AFTER DELETE ON public.sigorta_sirketleri FOR EACH ROW EXECUTE FUNCTION public.sigorta_police_sil();


--
-- Name: sigorta_sirketleri sigorta_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sigorta_trigger AFTER DELETE ON public.sigorta_sirketleri FOR EACH ROW EXECUTE FUNCTION public.sigorta_sirket_sil();


--
-- Name: musteri_tercihleri lnk_arac_ek_ozellikleri_musteri_tercihleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_tercihleri
    ADD CONSTRAINT lnk_arac_ek_ozellikleri_musteri_tercihleri FOREIGN KEY (ozellik_id) REFERENCES public.arac_ek_ozellikleri(ozellik_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilik_arac_ek_ozellikleri lnk_arac_ek_satilik_ek_ozellikler; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_arac_ek_ozellikleri
    ADD CONSTRAINT lnk_arac_ek_satilik_ek_ozellikler FOREIGN KEY (ozellik_id) REFERENCES public.arac_ek_ozellikleri(ozellik_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilik_araclar lnk_arac_kategorileri_satilik_araclar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_araclar
    ADD CONSTRAINT lnk_arac_kategorileri_satilik_araclar FOREIGN KEY (kategori_no) REFERENCES public.arac_kategorileri(kategori_no) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilik_araclar lnk_arac_modelleri_satilik_araclar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_araclar
    ADD CONSTRAINT lnk_arac_modelleri_satilik_araclar FOREIGN KEY (model_no) REFERENCES public.arac_modelleri(model_no) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: arac_kredisi lnk_finans_sirketleri_arac_kredisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kredisi
    ADD CONSTRAINT lnk_finans_sirketleri_arac_kredisi FOREIGN KEY (finans_sirket_id) REFERENCES public.finans_sirketleri(sirket_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: adresler lnk_musteriler_adresler; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adresler
    ADD CONSTRAINT lnk_musteriler_adresler FOREIGN KEY (musteri_id) REFERENCES public.musteriler(musteri_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: musteri_odemeleri lnk_musteriler_musteri_odemeleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_odemeleri
    ADD CONSTRAINT lnk_musteriler_musteri_odemeleri FOREIGN KEY (musteri_id) REFERENCES public.musteriler(musteri_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: musteri_tercihleri lnk_musteriler_musteri_tercihleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_tercihleri
    ADD CONSTRAINT lnk_musteriler_musteri_tercihleri FOREIGN KEY (musteri_id) REFERENCES public.musteriler(musteri_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilmis_araclar lnk_musteriler_satilmis_araclar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilmis_araclar
    ADD CONSTRAINT lnk_musteriler_satilmis_araclar FOREIGN KEY (musteri_id) REFERENCES public.musteriler(musteri_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: musteri_odemeleri lnk_odeme_durum_musteri_odemeleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_odemeleri
    ADD CONSTRAINT lnk_odeme_durum_musteri_odemeleri FOREIGN KEY (odeme_durum_no) REFERENCES public.odeme_durum(odeme_durum_no) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilik_arac_ek_ozellikleri lnk_satilik_araclar_ek_ozellikleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_arac_ek_ozellikleri
    ADD CONSTRAINT lnk_satilik_araclar_ek_ozellikleri FOREIGN KEY (arac_id) REFERENCES public.satilik_araclar(arac_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilmis_araclar lnk_satilik_araclar_satilmis_araclar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilmis_araclar
    ADD CONSTRAINT lnk_satilik_araclar_satilmis_araclar FOREIGN KEY (arac_id) REFERENCES public.satilik_araclar(arac_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: arac_kredisi lnk_satilmis_araclar_arac_kredisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arac_kredisi
    ADD CONSTRAINT lnk_satilmis_araclar_arac_kredisi FOREIGN KEY (satis_id) REFERENCES public.satilmis_araclar(satis_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: musteri_odemeleri lnk_satilmis_araclar_musteri_odemeleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri_odemeleri
    ADD CONSTRAINT lnk_satilmis_araclar_musteri_odemeleri FOREIGN KEY (satis_id) REFERENCES public.satilmis_araclar(satis_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sigorta_policeleri lnk_satilmis_araclar_sigorta_policeleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_policeleri
    ADD CONSTRAINT lnk_satilmis_araclar_sigorta_policeleri FOREIGN KEY (satis_id) REFERENCES public.satilmis_araclar(satis_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sigorta_policeleri lnk_sigorta_sirketleri_sigorta_policeleri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_policeleri
    ADD CONSTRAINT lnk_sigorta_sirketleri_sigorta_policeleri FOREIGN KEY (sigorta_sirket_id) REFERENCES public.sigorta_sirketleri(sirket_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: satilik_araclar lnk_ureticiler_satilik_araclar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.satilik_araclar
    ADD CONSTRAINT lnk_ureticiler_satilik_araclar FOREIGN KEY (uretici_id) REFERENCES public.ureticiler(uretici_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: finans_sirketleri sirket_finans_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finans_sirketleri
    ADD CONSTRAINT "sirket_finans_FK" FOREIGN KEY (sirket_id) REFERENCES public.sirketler(sirket_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sigorta_sirketleri sirket_sigorta_Cs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sigorta_sirketleri
    ADD CONSTRAINT "sirket_sigorta_Cs" FOREIGN KEY (sirket_id) REFERENCES public.sirketler(sirket_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

