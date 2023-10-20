VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub stocks()

    'identify variables
    Dim currTicker As String
    Dim nextTicker As String
    Dim yrChange As Double
    Dim pctChange As Double
    Dim totalVol As Double
    Dim row As Double
    Dim summaryRow As Double
    Dim lastRow As Double
    Dim closePrice As Double
    Dim openPrice As Double
    
     Dim ws As Worksheet
    
    ' Loop through all of the worksheets in the active workbook.
    For Each ws In ThisWorkbook.Worksheets
        ' column headers
        ws.Cells(1, 10).Value = "Ticker"
        ws.Cells(1, 11).Value = "Yearly Change"
        ws.Cells(1, 12).Value = "Percent Change"
        ws.Cells(1, 13).Value = "Total Volume"

        'set defaults
        totalVol = 0
        summaryRow = 2
        lastRow = ws.Cells(Rows.Count, 1).End(xlUp).row
    
        'for row 2 to 22771 identify ticker
        For row = 2 To lastRow
            currTicker = ws.Cells(row, 1).Value
            nextTicker = ws.Cells(row + 1, 1).Value
        
            'get open price for first date
            openPrice = ws.Cells(row, 3).Value
    
            'yearly change: take difference b/w first open value (col C) and last close value (col F)
            closePrice = ws.Cells(row, 6).Value
            yrChange = closePrice - openPrice
            
            'percent change: divide first open value (col C) by last close value (col F) and multiply by 100
            pctChange = (yrChange / closePrice) * 100
            
            'sum volume (col G) for each row of that stock
            totalVol = totalVol + ws.Cells(row, 7).Value
            
            'when ticker value is different, get close price, calc yr change and prcnt change, and write yr change, prcnt change, and sum in columns K, L, M
            If nextTicker <> currTicker Then
                    'yearly change: take difference b/w first open value (col C) and last close value (col F)
                closePrice = ws.Cells(row, 6).Value
                yrChange = closePrice - openPrice
            
                'percent change: divide first open value (col C) by last close value (col F) and multiply by 100
                pctChange = (yrChange / openPrice)
                
                ws.Cells(summaryRow, 10).Value = currTicker
                ws.Cells(summaryRow, 11).Value = yrChange
                ws.Cells(summaryRow, 12).Value = pctChange
                ws.Cells(summaryRow, 13).Value = totalVol
                
                'Conditional Formatting for year change: positive change is green, negative change is red
                If yrChange < 0 Then
                ws.Cells(summaryRow, 11).Interior.ColorIndex = 3
                Else
                ws.Cells(summaryRow, 11).Interior.ColorIndex = 4
                End If
                
                'Conditional Formatting for % change: positive change is green, negative change is red
                If pctChange < 0 Then
                ws.Cells(summaryRow, 12).Interior.ColorIndex = 3
                Else
                ws.Cells(summaryRow, 12).Interior.ColorIndex = 4
                End If
                
                'Format pctChange to have % and both pctChange and yrChange to have 2 decimal spots
                ws.Columns(12).NumberFormat = "0.00%"
                ws.Columns(11).NumberFormat = "0.00"

                
            'reset defaults and move to next ticker
                totalVol = 0
                summaryRow = summaryRow + 1
                openPrice = ws.Cells(row + 1, 3).Value
            End If
        Next row
    
    'greatest % inc, greatest % dec, and greatest total vol in column R (18)
        Dim greatestPctInc As Double
        Dim greatestPctIncTicker As String
        Dim greatestPctDec As Double
        Dim greatestPctDecTicker As String
        Dim greatestTotVol As Double
        Dim greatestTotVolTicker As String
        Dim lastSummaryRow As Long
        
        ws.Cells(1, 17).Value = "Ticker"
        ws.Cells(1, 18).Value = "Value"
        
        lastSummaryRow = ws.Cells(ws.Rows.Count, 10).End(xlUp).row
        greatestPctInc = ws.Cells(2, 12).Value
        greatestPctIncTicker = ws.Cells(2, 10).Value
        greatestPctDec = ws.Cells(2, 12).Value
        greatestPctDecTicker = ws.Cells(2, 10).Value
        greatestTotVol = ws.Cells(2, 13).Value
        greatestTotVolTicker = ws.Cells(2, 10).Value
        
        For row = 2 To lastSummaryRow
        
            If ws.Cells(row, 12).Value > greatestPctInc Then
                greatestPctInc = ws.Cells(row, 12).Value
                greatestPctIncTicker = ws.Cells(row, 10).Value
            End If
            
            If ws.Cells(row, 12).Value < greatestPctDec Then
                greatestPctDec = ws.Cells(row, 12).Value
                greatestPctDecTicker = ws.Cells(row, 10).Value
            End If
            
             If ws.Cells(row, 13).Value > greatestTotVol Then
                greatestTotVol = ws.Cells(row, 13).Value
                greatestTotVolTicker = ws.Cells(row, 10).Value
            End If
            
        Next row
        
        ws.Cells(2, 17).Value = greatestPctIncTicker
        ws.Cells(3, 17).Value = greatestPctDecTicker
        ws.Cells(4, 17).Value = greatestTotVolTicker
        ws.Cells(2, 18).Value = greatestPctInc
        ws.Cells(3, 18).Value = greatestPctDec
        ws.Cells(4, 18).Value = greatestTotVol
    
    Next ws

End Sub


