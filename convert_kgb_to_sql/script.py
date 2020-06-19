import csv

sql_output = ""

# open file
with open("C:\\Users\\kelvi\\DataShare\\data\\database_record_creation\\kbj_data\\sql_aps_qca_qfhs_data.csv", newline='') as csvfile:

    # get data from file
    data = csv.reader(csvfile, delimiter=',', quotechar='"')

    # skip the headers
    next(data, None)

    # loop through each record
    for row in data:

        # create variables for each field in record
        # db table: person
        row_id = row[0]
        row_data_source_id = row[1]
        row_family_name = row[2]
        row_first_names = row[3]
        row_title = row[4]
        # db table: m2m_person_ceda
        row_aps_first_year = row[5]
        row_aps_last_year = row[6]
        row_cqa_first_year = row[7]
        row_cqa_last_year = row[8]
        # db table: m2m_person_religion
        row_religion = row[9]
        row_confirmed = row[10]
        row_notes = row[11]




        # only insert new data in person table if no Id is provided (as these are new people)
        if row_id == '':

            # person table
            sql_output += """
INSERT INTO person(family_name, first_names, title_id, data_source_id)
VALUES ("{}", "{}", {}, {})
""".format(row_family_name, row_first_names, row_title, row_data_source_id)

        # for all records, insert into m2m tables

        # m2m_person_ceda table
        sql_output += """
INSERT INTO m2m_person_ceda
"""

print(sql_output)