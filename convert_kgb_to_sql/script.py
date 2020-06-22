import csv

# Path of the input and output data files
# input_data_file = "C:\\Users\\kelvi\\DataShare\\data\\database_record_creation\\kbj_data\\sql_aps_qca_qfhs_data.csv"
input_data_file = "/Users/mike/DataShare/data (Kelvin Beer-Jones)/database_record_creation/kbj_data/sql_aps_qca_qfhs_data.csv"
output_data_file = "/Users/mike/DataShare/ceda-database (Kelvin Beer-Jones)/convert_kgb_to_sql/output.sql"

# Built string of SQL throughout script to write to file at end of script
sql_output = ""

# Values from database, required when inserting new data in script
db_person_id = 2260 # the current max id value of person in db, used to set id of new person values
db_data_source_ids = {
    'RAI' : 1,
    'QCA' : 2,
    'APS' : 3
}

# function to replace empty strings from csv with 'NULL' 
def value_or_null(value, valueisastring=False):
    v = value if valueisastring != True else '"{}"'.format(value.replace('"', "'"))
    return v if value != '' else "NULL"

# open file
with open(input_data_file, newline='') as csvfile:

    # get data from file
    data = csv.reader(csvfile, delimiter=',', quotechar='"')

    # skip the headers
    next(data, None)

    # loop through each record
    for row in data:

        # create variables for each field in record
        # db table: person
        row_id = value_or_null(row[0])
        row_data_source_id = value_or_null(row[1])
        row_family_name = value_or_null(row[2], True)
        row_first_names = value_or_null(row[3], True)
        row_title = value_or_null(row[4], True)
        # db table: m2m_person_ceda
        row_aps_first_year = value_or_null(row[5])
        row_aps_last_year = value_or_null(row[6])
        row_qca_first_year = value_or_null(row[7])
        row_qca_last_year = value_or_null(row[8])
        # db table: m2m_person_religion
        row_religion = 1 if row[9] == "Quaker" else "NULL" # set to id of 'Quaker' in religion table (1) or NULL 
        row_confirmed = 1 if row[10] == '1' else 0 # if anything but 1 (true) set to 0 (false) - e.g. if blank
        row_notes = value_or_null(row[11], True)

        # only insert new data in person table if no Id is provided (as these are new people)
        if row_id == 'NULL':

            # person table
            db_person_id += 1
            sql_output += """
INSERT INTO person(id, family_name, first_names, title, data_source_id)
VALUES ({}, {}, {}, {}, {});
""".format(db_person_id, row_family_name, row_first_names, row_title, db_data_source_ids[row_data_source_id])

            person_fk_id = db_person_id
        
        # else, if the db_person_id is known (is an existing person) set it as the person_fk_id to be used in m2m inserts below
        else:
            person_fk_id = row_id

        # m2m_person_ceda table for APS (if first or last year provided)
        if row_aps_first_year != 'NULL' or row_aps_last_year != 'NULL':
            sql_output += """
INSERT INTO m2m_person_ceda(person_id, ceda_id, first_year, last_year)
VALUES ({}, {}, {}, {});
""".format(person_fk_id, 2, row_aps_first_year, row_aps_last_year)

        # m2m_person_ceda table for QCA (if first or last year provided)
        if row_qca_first_year != 'NULL' or row_qca_last_year != 'NULL':
            sql_output += """
INSERT INTO m2m_person_ceda(person_id, ceda_id, first_year, last_year)
VALUES ({}, {}, {}, {});
""".format(person_fk_id, 1, row_qca_first_year, row_qca_last_year)

        # m2m_person_religion table
        sql_output += """
INSERT INTO m2m_person_religion(person_id, religion_id, confirmed, notes)
VALUES ({}, {}, {}, {});
""".format(person_fk_id, row_religion, row_confirmed, row_notes)

with open(output_data_file, "w") as file:
    file.write(sql_output)
