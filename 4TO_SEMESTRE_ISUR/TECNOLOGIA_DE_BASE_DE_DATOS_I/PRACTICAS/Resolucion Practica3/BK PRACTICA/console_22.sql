--EJE3
--tranformar un tabla en un de conversiones
--ej1

--      MONEDA      RATIO
--      USD         3.46
--      EUR         4

--TRANSFORMARLO EN

--      MONEDA          EUR         PEN         USD
--      EUR             1           4           ??
--      PEN             0.?         1           0.?
--      USD             0.?         3.46        1
--
create table Monedas
(
    Código varchar(5),
    Nombre varchar(250),
    Ratio  money
)
go

INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AED', 'U.A.E Dirham', 0.923834);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AFN', 'Afghan afghani', 0.042995);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ALL', 'Albanian lek', 0.030383);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AMD', 'Armenia Dram', 0.007115);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ANG', 'Neth. Antillean Guilder', 1.960641);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AOA', 'Angolan kwanza', 0.007083);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ARS', 'Argentine Peso', 0.056596);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AUD', 'Australian Dollar', 2.298019);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AWG', 'Aruban florin', 1.868737);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('AZN', 'Azerbaijan Manat', 1.997724);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BAM', 'Bosnia and Herzegovina convertible mark', 1.903719);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BBD', 'Barbadian Dollar', 1.693359);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BDT', 'Bangladeshi taka', 0.040233);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BGN', 'Bulgarian Lev', 1.90867);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BHD', 'Bahrain Dinar', 8.99396);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BIF', 'Burundian franc', 0.001804);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BND', 'Brunei Dollar', 2.481932);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BOB', 'Bolivian Boliviano', 0.491631);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BRL', 'Brazilian Real', 0.796331);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BSD', 'Bahamian Dollar', 3.381952);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BWP', 'Botswana Pula', 0.310906);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BYN', 'Belarussian Ruble', 1.606835);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('BZD', 'Belize dollar', 1.677847);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CAD', 'Canadian Dollar', 2.552152);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CDF', 'Congolese franc', 0.002032);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CHF', 'Swiss Franc', 3.395031);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CLP', 'Chilean Peso', 0.004251);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CNY', 'Chinese Yuan', 0.482329);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('COP', 'Colombian Peso', 0.000976);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CRC', 'Costa Rican Col¢n', 0.00602);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CUP', 'Cuban peso', 3.381952);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CVE', 'Cape Verde escudo', 0.033427);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('CZK', 'Czech Koruna', 0.146193);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('DJF', 'Djiboutian franc', 0.018998);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('DKK', 'Danish Krone', 0.499664);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('DOP', 'Dominican Peso', 0.064004);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('DZD', 'Algerian Dinar', 0.028319);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('EGP', 'Egyptian Pound', 0.210332);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ERN', 'Eritrean nakfa', 0.224404);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ETB', 'Ethiopian birr', 0.111165);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('EUR', 'Euro', 3.734337);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('FJD', 'Fiji Dollar', 1.544742);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GBP', 'U.K. Pound Sterling', 4.3841);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GEL', 'Georgian lari', 1.162111);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GHS', 'Ghanaian Cedi', 0.629289);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GIP', 'Gibraltar pound', 4.35005);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GMD', 'Gambian dalasi', 0.065818);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GNF', 'Guinean franc', 0.000355);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GTQ', 'Guatemalan Quetzal', 0.43922);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('GYD', 'Guyanese dollar', 0.016208);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('HKD', 'Hong Kong Dollar', 0.433094);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('HNL', 'Honduran Lempira', 0.137337);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('HRK', 'Croatian Kuna', 0.501814);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('HTG', 'Haitian gourde', 0.034809);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('HUF', 'Hungarian Forint', 0.011103);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('IDR', 'Indonesian Rupiah', 0.00024);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ILS', 'Israeli New Sheqel', 0.97703);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('INR', 'Indian Rupee', 0.047465);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('IQD', 'Iraqi dinar', 0.002891);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('IRR', 'Iranian rial', 0.000081);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ISK', 'Icelandic Krona', 0.027648);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('JMD', 'Jamaican Dollar', 0.02479);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('JOD', 'Jordanian Dinar', 4.772266);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('JPY', 'Japanese Yen', 0.03099);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KES', 'Kenyan shilling', 0.033033);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KGS', 'Kyrgyzstan Som', 0.048569);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KHR', 'Cambodian riel', 0.000828);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KMF', 'Comoro franc', 0.007554);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KRW', 'South Korean Won', 0.002878);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KWD', 'Kuwaiti Dinar', 11.161496);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('KZT', 'Kazakhstani Tenge', 0.008771);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LAK', 'Lao kip', 0.000382);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LBP', 'Lebanese Pound', 0.002271);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LKR', 'Sri Lanka Rupee', 0.01868);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LRD', 'Liberian dollar', 0.017534);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LSL', 'Lesotho loti', 0.229673);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('LYD', 'Libyan Dinar', 2.453293);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MAD', 'Moroccan Dirham', 0.357394);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MDL', 'Moldova Lei', 0.194346);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MGA', 'Malagasy ariary', 0.000918);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MKD', 'Macedonian denar', 0.06043);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MMK', 'Myanma Kyat', 0.002246);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MNT', 'Mongolian togrog', 0.001255);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MOP', 'Macanese pataca', 0.419267);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MRU', 'Mauritanian ouguiya', 0.090263);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MUR', 'Mauritian Rupee', 0.092396);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MVR', 'Maldivian rufiyaa', 0.218789);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MWK', 'Malawian kwacha', 0.004593);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MXN', 'Mexican Peso', 0.173616);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MYR', 'Malaysian Ringgit', 0.812733);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('MZN', 'Mozambican metical', 0.053207);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NAD', 'Namibian dollar', 0.229155);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NGN', 'Nigerian Naira', 0.011047);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NIO', 'Nicaraguan C¢rdoba', 0.100373);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NOK', 'Norwegian Krone', 0.369478);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NPR', 'Nepalese Rupee', 0.029638);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('NZD', 'New Zealand Dollar', 2.178668);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('OMR', 'Omani Rial', 8.790621);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PAB', 'Panamanian Balboa', 3.381952);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PGK', 'Papua New Guinean kina', 0.99606);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PHP', 'Philippine Peso', 0.066707);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PKR', 'Pakistani Rupee', 0.022075);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PLN', 'Polish Zloty', 0.86547);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('PYG', 'Paraguayan Guaran¡', 0.000524);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('QAR', 'Qatari Rial', 0.922751);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('RON', 'Romanian New Leu', 0.780037);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('RSD', 'Serbian Dinar', 0.031862);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('RUB', 'Russian Rouble', 0.052948);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('RWF', 'Rwandan franc', 0.003623);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SAR', 'Saudi Riyal', 0.90399);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SBD', 'Solomon Islands dollar', 0.415985);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SCR', 'Seychelles rupee', 0.246862);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SDG', 'Sudanese pound', 0.074974);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SEK', 'Swedish Krona', 0.353624);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SGD', 'Singapore Dollar', 2.482505);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SLL', 'Sierra Leonean leone', 0.000349);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SOS', 'Somali shilling', 0.005847);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SRD', 'Surinamese dollar', 0.452436);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SSP', 'South Sudanese pound', 0.021305);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('STN', 'SÆo Tom‚ and Pr¡ncipe Dobra', 0.149516);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SVC', 'Salvadoran colon', 0.386358);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SYP', 'Syrian pound', 0.007774);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('SZL', 'Swazi lilangeni', 0.229673);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('THB', 'Thai Baht', 0.112195);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TJS', 'Tajikistan Ruble', 0.350662);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TMT', 'New Turkmenistan Manat', 0.972545);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TND', 'Tunisian Dinar', 1.212731);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TOP', 'Tongan pa?anga', 1.465881);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TRY', 'Turkish Lira', 0.587756);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TTD', 'Trinidad Tobago Dollar', 0.500547);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TWD', 'New Taiwan Dollar ', 0.111248);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('TZS', 'Tanzanian shilling', 0.00147);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('UAH', 'Ukrainian Hryvnia', 0.141002);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('UGX', 'Ugandan shilling', 0.000914);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('USD', 'U.S. Dollar', 3.390416);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('UYU', 'Uruguayan Peso', 0.089274);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('UZS', 'Uzbekistan Sum', 0.000358);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('VES', 'Venezuelan Bolivar', 0.000095);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('VND', 'Vietnamese Dong', 0.000146);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('VUV', 'Vanuatu vatu', 0.028596);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('WST', 'Samoan tala', 1.26644);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('XAF', 'Central African CFA Franc', 0.005678);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('XCD', 'East Caribbean Dollar', 1.249424);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('XOF', 'West African CFA Franc', 0.00568);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('XPF', 'CFP Franc', 0.031199);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('YER', 'Yemeni rial', 0.013564);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ZAR', 'South African Rand', 0.230021);
INSERT INTO Northwind.dbo.Monedas (Código, Nombre, Ratio)
VALUES ('ZMW', 'Zambian kwacha', 0.23045);

declare @monedas varchar(max);

select @monedas = string_agg(quotename(Monedas.Código), ',')
from Monedas;

select @monedas;

select M1.Código, M1.Nombre, M2.Código, M1.Ratio / M2.Ratio conversion
from Monedas M1
         cross join Monedas M2;

select *
from (select M1.Código Monedas, M1.Nombre Nombre_Moneda, M2.Código C2, M1.Ratio / M2.Ratio conversion
      from Monedas M1
               cross join Monedas M2) PT1
pivot ( sum(conversion) for C2 IN ([AED],[AFN],[ALL],[AMD],[ANG],[AOA],[ARS],[AUD],[AWG],[AZN],[BAM],[BBD],[BDT],[BGN],[BHD],[BIF],[BND],[BOB],[BRL],[BSD],[BWP],[BYN],[BZD],[CAD],[CDF],[CHF],[CLP],[CNY],[COP],[CRC],[CUP],[CVE],[CZK],[DJF],[DKK],[DOP],[DZD],[EGP],[ERN],[ETB],[EUR],[FJD],[GBP],[GEL],[GHS],[GIP],[GMD],[GNF],[GTQ],[GYD],[HKD],[HNL],[HRK],[HTG],[HUF],[IDR],[ILS],[INR],[IQD],[IRR],[ISK],[JMD],[JOD],[JPY],[KES],[KGS],[KHR],[KMF],[KRW],[KWD],[KZT],[LAK],[LBP],[LKR],[LRD],[LSL],[LYD],[MAD],[MDL],[MGA],[MKD],[MMK],[MNT],[MOP],[MRU],[MUR],[MVR],[MWK],[MXN],[MYR],[MZN],[NAD],[NGN],[NIO],[NOK],[NPR],[NZD],[OMR],[PAB],[PGK],[PHP],[PKR],[PLN],[PYG],[QAR],[RON],[RSD],[RUB],[RWF],[SAR],[SBD],[SCR],[SDG],[SEK],[SGD],[SLL],[SOS],[SRD],[SSP],[STN],[SVC],[SYP],[SZL],[THB],[TJS],[TMT],[TND],[TOP],[TRY],[TTD],[TWD],[TZS],[UAH],[UGX],[USD],[UYU],[UZS],[VES],[VND],[VUV],[WST],[XAF],[XCD],[XOF],[XPF],[YER],[ZAR],[ZMW]) ) PV1;


begin
    declare @monedas varchar(max);

    select @monedas = string_agg(quotename(Monedas.Código), ',')
    from Monedas;

    exec ('select *
        from (select M1.Código Monedas, M1.Nombre Nombre_Moneda, M2.Código C2, M1.Ratio / M2.Ratio conversion
              from Monedas M1
                       cross join Monedas M2) PT1
        pivot ( sum(conversion) for C2 IN ('+@monedas+') ) PV1;
        ');
end;
