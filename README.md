# QRCODE-VB6.0-TLV-BASE64
QRCODE FOR VB 6.0 TLV BASE64 WITH PYTHON EXE
ZATCA (Zakat Tax and Customs Authority) for e-invoicing requirements in Saudi Arabia (1ST TSTAGE)
![QRVB6 0](https://user-images.githubusercontent.com/20999411/143688978-5f716a0d-343c-4843-b73d-d808d58eae23.png)
qrcode generation  dll used from https://github.com/perevoznyk/quricol


BETTER SOLUTION SQL NATIVE AND FASTER

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QrCodeBase64Gen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[QrCodeBase64Gen]

go

CREATE Procedure [dbo].[QrCodeBase64Gen]
	@HexVal varchar(500)
as

SET ARITHABORT ON
SELECT
    CAST(N'' AS XML).value(
          'xs:base64Binary(xs:hexBinary(sql:column("bin")))'
        , 'VARCHAR(MAX)'
    )   Base64Encoding
FROM (
    SELECT @HexVal AS bin
) AS bin_sql_server_temp;
