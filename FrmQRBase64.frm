VERSION 5.00
Begin VB.Form FrmQrBase64 
   Caption         =   "Form2"
   ClientHeight    =   11385
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   20235
   LinkTopic       =   "Form2"
   ScaleHeight     =   11385
   ScaleWidth      =   20235
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox TxtBase64 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   720
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   4200
      Width           =   18255
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   660
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   2940
      Width           =   18255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   915
      Left            =   1200
      TabIndex        =   0
      Top             =   5640
      Width           =   1785
   End
   Begin VB.Image Image1 
      Height          =   2055
      Left            =   7440
      Top             =   6720
      Width           =   1935
   End
End
Attribute VB_Name = "FrmQrBase64"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 
Private Enum TErrorCorretion
    QualityLow
    QualityMedium
    QualityStandard
    QualityHigh
End Enum
 
Private Declare Sub GenerateBMP Lib "C:\Tools\quricol32.dll" _
                Alias _
                "GenerateBMPW" ( _
                ByVal FileName As Long, _
                ByVal Text As Long, _
                ByVal Margin As Long, _
                ByVal Size As Long, _
                ByVal Level As TErrorCorretion)

Private Sub Command1_Click()
Dim VenName As String
Dim VatNo, Dttime, Total, Vat As String
Dim tlvfield1, tlvfield2, tlvfield3, tlvfield4, tlvfield5, tlvfields
'VenName = "ÇáãõÍÞøÞÉ (ßÇÑÊÑ)¡ ãÑÍÈðÇ Èßö Ýí  ÑæÊÔöá"
VenName = "Bin Madi Computers(Èä ãÇÕí) Khamis/hbinmadi@yahoo.com "
VatNo = "310122393500003"
Dttime = "2022-04-25 15:30:00AM"
Total = "1000.00"
Vat = "150.00"

VenName = UTF8ENCODE(VenName)
VatNo = UTF8ENCODE(VatNo)
Dttime = UTF8ENCODE(Dttime)
Total = UTF8ENCODE(Total)
Vat = UTF8ENCODE(Vat)


tlvfield1 = "01" + HexVal(Len(VenName)) + StringtoHex(VenName)
'TxtName.text = StringtoHex(VenName)

tlvfield2 = "02" + HexVal(Len(VatNo)) + StringtoHex(VatNo)
'TxtVNo.text = tlvfield2
tlvfield3 = "03" + HexVal(Len(Dttime)) + StringtoHex(Dttime)
'TxtDate.text = tlvfield3
tlvfield4 = "04" + HexVal(Len(Total)) + StringtoHex(Total)
tlvfield5 = "05" + HexVal(Len(Vat)) + StringtoHex(Vat)




tlvfields = tlvfield1 + tlvfield2 + tlvfield3 + tlvfield4 + tlvfield5


'concat byte arrays



Text1 = tlvfields

Clipboard.Clear
Clipboard.SetText Text1.Text

Dim Parameter As String
Dim Res As Long
Parameter = tlvfields
Dim FileName As String
    FileName = "C:\tools\qr.exe" 'Check file is here first
If Dir(FileName) = "" Then
    MsgBox FileName & " not found with parameter " & Parameter, vbInformation
Else
    Res = Shell(FileName & " " & Parameter, vbHide)
End If

TxtBase64.Text = FileToString("C:\tools\qrcode.txt")




GenerateBMP StrPtr(App.Path & "\Example.jpeg"), StrPtr(TxtBase64.Text), 3, 5, QualityLow
Image1.Picture = LoadPicture(App.Path & "\Example.jpeg")




End Sub
Function FileToString(strFilename As String) As String
  iFile = FreeFile
  Open strFilename For Input As #iFile
    FileToString = StrConv(InputB(LOF(iFile), iFile), vbUnicode)
  Close #iFile
End Function

Public Function HexVal(FindHex As String) As String
 If Len(Hex$(FindHex)) > 1 Then
    HexVal = Hex$(FindHex)
 Else
    HexVal = "0" + Hex$(FindHex)
 End If
 'HexVal = HexToString(HexVal)
End Function
Private Function StringtoHex(ByVal tmpStr As String) As String
Dim i As Integer
Dim tmpl As String
    For i = 1 To Len(tmpStr)
        tmpl = tmpl & Hex(Asc(Mid$(tmpStr, i, 1)))
    Next i
    StringtoHex = Trim$(tmpl)
End Function

Public Function UTF8ENCODE(ByVal sStr As String) As String

    For l& = 1 To Len(sStr)

        lChar& = AscW(Mid(sStr, l&, 1))

        If lChar& < 128 Then
            sUtf8$ = sUtf8$ + Mid(sStr, l&, 1)
        ElseIf ((lChar& > 127) And (lChar& < 2048)) Then

            sUtf8$ = sUtf8$ + Chr(((lChar& \ 64) Or 192))
            sUtf8$ = sUtf8$ + Chr(((lChar& And 63) Or 128))

        Else

            sUtf8$ = sUtf8$ + Chr(((lChar& \ 144) Or 234))
            sUtf8$ = sUtf8$ + Chr((((lChar& \ 64) And 63) Or 128))
            sUtf8$ = sUtf8$ + Chr(((lChar& And 63) Or 128))

        End If
    Next l&

    UTF8ENCODE = sUtf8$

End Function

