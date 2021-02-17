from utility_functions import *

result = pd.DataFrame()

# Merging CSVs by month
start_month = 1
end_month = 12
printProgressBar(0, end_month + 1)

for i in range(1, end_month + 1):
    if i < 10:
        i = "0" + str(i)

    path = f'./New/flights_{i}.csv'
    temp = pd.read_csv(path, index_col=False,
                       low_memory=False, na_filter=False)
    result = result.append(temp, ignore_index=True)
    printProgressBar(int(i), end_month + 1)


# # Merging CSVs by year
# years = [2020, 2019, 2018, 2017, 2016, 2015]
# headers = ['YEAR', 'MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK', 'OP_UNIQUE_CARRIER', 'ORIGIN_CITY_NAME',
#            'ORIGIN_STATE_ABR', 'DEST_CITY_NAME', 'DEST_STATE_ABR', 'CRS_DEP_TIME', 'DEP_DELAY_NEW',
#            'CRS_ARR_TIME', 'ARR_DELAY_NEW', 'CANCELLED', 'CANCELLATION_CODE', 'AIR_TIME', 'DISTANCE']

# for year in years:
#     path = f'./flights_{year}.csv'
#     temp = pd.read_csv(path, index_col=False,
#                        low_memory=False, na_filter=False, names=headers)
#     result = result.append(temp, ignore_index=True)

result.to_csv('flights_total.csv', index=False, header=False)
printProgressBar(end_month + 1, end_month + 1)
