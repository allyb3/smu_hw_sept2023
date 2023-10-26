# Modules
import csv

# Set path for file
csvpath = "PyPoll/resources/election_data.csv"

# Set the variables
total_votes = 0
candidates_list = {}
winning_candidate = ""
winning_votes = 0


# Open the CSV using the UTF-8 encoding
with open(csvpath, encoding='UTF-8') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")

    # Read the header row first 
    csv_header = next(csvreader)

    # Read each row of data after the header
    for row in csvreader:
        # print(row)


        # Add 1 to month counter
        total_votes = total_votes + 1

        # add candidate name to candidate list if it is new, give value of 1. if not new then add 1 to the value
        candidate = row[2]
        if candidate in candidates_list.keys():
            candidates_list[candidate] = candidates_list[candidate] + 1
        else: 
            candidates_list[candidate] = 1
    
    for candidate in candidates_list.keys():
        votes = candidates_list[candidate]


        if votes > winning_votes:
            winning_candidate = candidate
            winning_votes = votes


# print out KPIs in format
# source: https://www.altcademy.com/blog/how-to-print-a-dictionary-in-python/


    print("Election Results")
    print("---------------------------------")
    print("Total Votes: ", total_votes)
    print("---------------------------------")
    for candidate in candidates_list.keys():
            votes = candidates_list[candidate]
            perc = (votes / total_votes)*100
            print(candidate, ": ",perc, "% (", votes, ")")
    print("---------------------------------")
    print("Winner: ", winning_candidate)

## need to debug printing to txt file
# with open("output_AEB.txt", "w") as txt_file:
#     output = f""""
#     Election Results
#     ---------------------
#     Total Votes: {total_votes}
#     ---------------------

#     {candidate}: {perc}% ({votes})
#     ---------------------
#     Winner: {winning_candidate}
#     """
#     txt_file.write(output)



