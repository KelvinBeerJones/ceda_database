import csv

# Path of the input and output data files
input_data_file = "qfhs_sql_input.csv"
output_data_file = "qfhs_sql_output.sql"

sql_output = ""  # Built string of SQL throughout script to write to file at end of script

# open file
with open(input_data_file, newline='') as csvfile:

    data = csv.reader(csvfile, delimiter=',', quotechar='"')  # get data from file
    next(data, None)  # skip the headers

    # loop through each record
    for row in data:

        # create variables for each field in record
        row_id = row[0]
        row_relationship_type = row[1]
        row_person_1 = row[2]
        row_person_2 = row[3]

        # m2m_person_person table
        sql_output += """
INSERT INTO m2m_person_person(relationship_type_id, person1_id, person2_id)
VALUES ({}, {}, {});
""".format(row_relationship_type, row_person_1, row_person_2)

# write the output to file
with open(output_data_file, "w") as file:
    file.write(sql_output)