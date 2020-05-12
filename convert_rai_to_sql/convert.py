import csv

data_person = []
data_sl_title = []
data_sl_gender = []
data_location = []
data_occupation = []
data_club = []
data_society = []
data_suffix = []


def uniqueList(rows, data_list):
    '''
        Loop through all supplied rows from CSV
        and build a unique list of values in the specified data_list
        e.g. a list of all unique locations in data_locations
    '''

    for r in rows:
        value = row[r].strip()
        if value not in data_list:
            data_list.append(value)



# open file
with open('sql_rai_data.csv', newline='') as csvfile:

    # get data from file
    data = csv.reader(csvfile, delimiter=',', quotechar='"')

    # skip the headers
    next(data, None)

    # loop through each record
    for row in data:

        # build unique lists of data for each relevant column (e.g. locations, genders, etc)
        uniqueList([3], data_sl_title)
        uniqueList([5], data_sl_gender)
        uniqueList([10, 11, 12, 13], data_location)
        uniqueList([24, 25, 26, 27], data_occupation)
        uniqueList([28, 29, 30], data_club)
        uniqueList([31, 32, 33, 34, 35, 36, 37], data_society)

        # build unique list of suffixes - these are all stored in single string that needs to be split by ', '
        for s in row[4].split(", "):
            suffix = s.strip()
            if suffix not in data_suffix:
                data_suffix.append(suffix)

    # Reset csvreader object
    csvfile.seek(0)
    next(data)

    # Loop through each record to build person table insert statements
    count = 1
    for row in data:

        data_person_record = {
            'id': count,
            'family_name': row[1],
            'first_names': row[2],
            'title_id': data_sl_title.index(row[3].strip()) + 1,
            'suffixes': row[4].split(', '),
            'gender_id': data_sl_gender.index(row[5].strip()) + 1,
            'birth_year': row[7],
            'death_year': row[8],
            'locations': [row[10], row[11], row[12], row[13]],
            'esl_join_year': row[14],
            'esl_left_year': row[15],
            'asl_join_year': row[16],
            'asl_left_year': row[17],
            'ai_join_year': row[18],
            'ai_left_year': row[19],
            'aps_join_year': row[20],
            'aps_left_year': row[21],
            'las_join_year': row[22],
            'las_left_year': row[23],
            'occupations': [row[24], row[25], row[26], row[27]],
            'clubs': [row[28], row[29], row[30]],
            'societies': [row[31], row[32], row[33], row[34], row[35], row[36], row[37]],
            'notes': row[9]
        }

        data_person.append(data_person_record)

        count += 1


# Build SQL insert statements

# person - not put into a function as its structure is unlike other tables
sql_insert_person = ""
for i in data_person:
    sql_insert_person += """
        INSERT INTO person
        VALUES (
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}",
        "{}"
        );
    """.format(
        i['id'],
        i['family_name'].replace(";", "\\;"),
        i['first_names'].replace(";", "\\;"),
        i['title_id'],
        i['gender_id'],
        i['birth_year'],
        i['death_year'],
        i['esl_join_year'],
        i['esl_left_year'],
        i['asl_join_year'],
        i['asl_left_year'],
        i['ai_join_year'],
        i['ai_left_year'],
        i['aps_join_year'],
        i['aps_left_year'],
        i['las_join_year'],
        i['las_left_year'],
        i['notes'].replace(";", "\\;")
    )

# write person SQL to file
with open("sql_insert_person.txt", "w") as file:
    file.write(sql_insert_person)



def generateSQLInserts(data_list, table_name):
    sql_insert = ""
    for i in data_list:
        sql_insert += """
            INSERT INTO {} (id, name)
            VALUES ("{}", "{}");
        """.format(table_name, data_list.index(i) + 1, i)

    with open("sql_insert_{}.txt".format(table_name), "w") as file:
        file.write(sql_insert)

generateSQLInserts(data_sl_title, 'sl_title')
generateSQLInserts(data_sl_gender, 'sl_gender')
generateSQLInserts(data_location, 'location')
generateSQLInserts(data_occupation, 'occupation')
generateSQLInserts(data_club, 'club')
generateSQLInserts(data_society, 'society')
generateSQLInserts(data_suffix, 'suffix')


# Many to many ---------------------------------------------------------------------------

def m2mPerson(data_name, data_list, column_name, table_name):
    '''
        1. Build a data object of M2M ids for person table
        2. Build a SQL script to insert these M2M records
        3. Output SQL script to file
    '''

    # 1. build data object
    data = []
    count = 1
    # loop through all persons
    for p in data_person:
        # loop through all data items for this person
        for l in p[data_name]:
            # loop through all unique values in data_list
            for i in data_list:
                # if there's a match and it's not blank
                if i == l and i != '':
                    # create a m2m record
                    data_record = {
                        'id': count,
                        'person_id': p['id'],
                        column_name: (data_list.index(i) + 1),
                    }
                    # add record to list of records
                    data.append(data_record)
                    count += 1

    # 2. build SQL
    sql_insert = ""
    for i in data:
        sql_insert += """
            INSERT INTO {} (id, person_id, {})
            VALUES ("{}", "{}", "{}");
        """.format(table_name, column_name, i['id'], i['person_id'], i[column_name])

    # 3. output SQL to file
    with open("sql_insert_" + table_name + ".txt", "w") as file:
        file.write(sql_insert)


m2mPerson('locations', data_location, "location_id", "m2m_person_location")
m2mPerson('occupations', data_occupation, "occupation_id", "m2m_person_occupation")
m2mPerson('clubs', data_club, "club_id", "m2m_person_club")
m2mPerson('societies', data_society, "society_id", "m2m_person_society")
m2mPerson('suffixes', data_suffix, "suffix_id", "m2m_person_suffix")


