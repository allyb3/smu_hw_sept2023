# Modules
import csv

# Set path for file
csvpath = "resources/budget_data.csv"

# Set the variables
total_months = 0
total_profit_loss = 0
change_list = []
last_profit_loss = 0
max_change = -999999
min_change = 999999
max_month = ""
min_month = ""

# Open the CSV using the UTF-8 encoding
with open(csvpath, encoding='UTF-8') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")

    # Read the header row first 
    csv_header = next(csvreader)
    print(f"CSV Header: {csv_header}")

    # Read each row of data after the header
    for row in csvreader:
        print(row)

        # row - last row = change; avg change
        # when i'm in the first row (total months = 0) there shouldn't be a change but it should be put into last profit loss
        if total_months != 0:
            change = int(row[1]) - last_profit_loss
            change_list.append(change)
            avg_change = sum(change_list)/len(change_list)

            # check if a minimum or maximum
            if change > max_change:
                max_change = change
                max_month = row[0]
            elif change < min_change:
                min_change = change
                min_month = row[0]
            else:
                pass
        
        last_profit_loss = int(row[1])

        # Add 1 to month counter
        total_months = total_months + 1

        # Sum profit/losses
        total_profit_loss = total_profit_loss + int(row[1])



# print out KPIs in format
with open("output_AEB.txt", "w") as txt_file:
    output = f"""
Financial Analysis
---------------------------------
Total Months: {total_months}
Total: ${total_profit_loss}
Average Change: ${round(avg_change, 2)}
Greatest Increase in Profits: {max_month} (${max_change})
Greatest Decrease in Profits: {min_month} (${min_change})"""

    txt_file.write(output)


