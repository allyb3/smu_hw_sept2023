Sub stocks()

    'identify variables
    Dim totalVol As Double
    Dim row As Long
    Dim change As Double
    Dim summaryRow As Integer
    Dim start As Long
    Dim rowCount As Long
    Dim percentChange As Double
    Dim days As Integer
    Dim dailyChange As Double
    Dim averageChange As Double
    Dim ws As Worksheet
    
    'Loop through all of the worksheets in the active workbook.
    For Each ws In ThisWorkbook.Worksheets
        'set defaults
        summaryRow = 1
        totalVol = 0
        change = 0
        start = 2
        dailyChange = 0

        'column headers
        ws.Cells(1, 10).Value = "Ticker"
        ws.Cells(1, 11).Value = "Yearly Change"
        ws.Cells(1, 12).Value = "Percent Change"
        ws.Cells(1, 13).Value = "Total Volume"
        ws.Cells(1, 17).Value = "Ticker"
        ws.Cells(1, 18).Value = "Value"
        ws.Cells(2, 16).Value = "Greatest % Increase"
        ws.Cells(3, 16).Value = "Greatest % Decrease"
        ws.Cells(4, 16).Value = "Greatest Total Volume"
        
        'find last row with data
        rowCount = Cells(Rows.Count, "A").End(xlUp).row
        
        For row = 2 To rowCount
        
            'if different ticker then print results
            If ws.Cells(row + 1, 1).Value <> ws.Cells(row, 1).Value Then
            
                'store results in variable
                totalVol = totalVol + ws.Cells(row, 7).Value
                
                'total volume is zero
                If totalVol = 0 Then
                    'print results
                    ws.Cells(summaryRow, 10).Value = Cells(row, 1).Value
                    ws.Cells(summaryRow, 11).Value = 0
                    ws.Cells(summaryRow, 12).Value = "%" & 0
                    ws.Cells(summaryRow, 13).Value = 0
                
                Else
                    'Find first non-zero starting value
                    If ws.Cells(start, 3) = 0 Then
                        For find_value = start To row
                            If ws.Cells(find_value, 3).Value <> 0 Then
                                start = find_value
                                Exit For
                            End If
                        Next find_value
                    End If
                    
                    'Calculate Change
                    change = (ws.Cells(row, 6) - ws.Cells(start, 3))
                    percentChange = change / ws.Cells(start, 3)
                    
                    'start next ticker
                    start = row + 1
                    
                    'print results
                    ws.Cells(summaryRow, 10).Value = ws.Cells(row, 1).Value
                    ws.Cells(summaryRow, 11).Value = change
                    ws.Cells(summaryRow, 11).NumberFormat = "0.00"
                    ws.Cells(summaryRow, 12).Value = percentChange
                    ws.Cells(summaryRow, 12).NumberFormat = "0.00%"
                    ws.Cells(summaryRow, 13).Value = totalVol
                    
                    'set colors red and green
                    Select Case change
                        Case Is > 0
                            ws.Range("K" & 2 + summaryRow).Interior.ColorIndex = 4
                        Case Is < 0
                            ws.Range("K" & 2 + summaryRow).Interior.ColorIndex = 3
                        Case Else
                            ws.Range("K" & 2 + summaryRow).Interior.ColorIndex = 0
                    End Select
                    End If
                    
                    'reset variables
                    totalVol = 0
                    change = 0
                    summaryRow = summaryRow + 1
                    days = 0
                    dailyChange = 0

               
                'add results if ticker is not different
                Else
                    totalVol = totalVol + ws.Cells(row, 7).Value
                End If
                
            Next row
            
            
            'grab greatest percent increase, greatest percent decrease, and greatest total vol
            ws.Cells(2, 18) = "%" & WorksheetFunction.Max(ws.Range("L2:L" & rowCount)) * 100
            ws.Cells(3, 18) = "%" & WorksheetFunction.Min(ws.Range("L2:L" & rowCount)) * 100
            ws.Cells(4, 18) = WorksheetFunction.Max(ws.Range("M2:M" & rowCount))
            
            'pull numbers
            increase_number = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("L2:L" & rowCount)), ws.Range("L2:L" & rowCount), 0)
            decrease_number = WorksheetFunction.Match(WorksheetFunction.Min(ws.Range("L2:L" & rowCount)), ws.Range("L2:L" & rowCount), 0)
            volume_number = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("M2:M" & rowCount)), ws.Range("M2:M" & rowCount), 0)
            
            'get tickers
            ws.Range("Q2") = ws.Cells(increase_number + 1, 9)
            ws.Range("Q3") = ws.Cells(decrease_number + 1, 9)
            ws.Range("Q4") = ws.Cells(volume_number + 1, 9)
        
        Next ws
    End Sub
                    
    

