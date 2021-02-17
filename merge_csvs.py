from utility_functions import *
import numpy as np

headers = ['YEAR', 'MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK', 'OP_UNIQUE_CARRIER', 'ORIGIN_CITY_NAME',
           'ORIGIN_STATE_ABR', 'DEST_CITY_NAME', 'DEST_STATE_ABR', 'CRS_DEP_TIME', 'DEP_DELAY_NEW',
           'CRS_ARR_TIME', 'ARR_DELAY_NEW', 'CANCELLED', 'CANCELLATION_CODE', 'AIR_TIME', 'DISTANCE']

types = {'YEAR': np.str, 'MONTH': np.str, 'DAY_OF_MONTH': np.str, 'DAY_OF_WEEK': np.str, 'OP_UNIQUE_CARRIER': np.str, 'ORIGIN_CITY_NAME': np.str,
         'ORIGIN_STATE_ABR': np.str, 'DEST_CITY_NAME': np.str, 'DEST_STATE_ABR': np.str, 'CRS_DEP_TIME': np.str, 'DEP_DELAY_NEW': np.str,
         'CRS_ARR_TIME': np.str, 'ARR_DELAY_NEW': np.str, 'CANCELLED': np.str, 'CANCELLATION_CODE': np.str, 'AIR_TIME': np.str, 'DISTANCE': np.str}

result = pd.DataFrame()

start_month = 1
end_month = 11

printProgressBar(0, end_month + 2, prefix='Progress:',
                 suffix='Complete', length=50)

for i in range(1, end_month + 1):
    if i < 10:
        i = "0" + str(i)

    path = f'./New/flights_{i}.csv'
    temp = pd.read_csv(path, names=headers, index_col=False,
                       low_memory=False, dtype=types)
    print(temp)
    result = result.append(temp, ignore_index=True)

    printProgressBar(int(i), end_month + 2, prefix='Progress:',
                     suffix='Complete', length=50)

result = result.fillna("NULL")
result = result.replace(r'^\s*$', 'NULL', regex=True)

printProgressBar(end_month + 1, end_month + 2, prefix='Progress:',
                 suffix='Complete', length=50)

result.to_csv('flights.csv', index=False, header=False)

printProgressBar(end_month + 2, end_month + 2, prefix='Progress:',
                 suffix='Complete', length=50)
