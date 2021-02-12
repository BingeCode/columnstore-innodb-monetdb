import pandas as pd

headers = ['YEAR', 'MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK', 'ORIGIN_CITY_NAME', 'ORIGIN_STATE_ABR', 'DEST_CITY_NAME',
           'DEST_STATE_ABR', 'DEP_TIME', 'DEP_DELAY_NEW', 'ARR_TIME', 'ARR_DELAY_NEW', 'CANCELLED', 'AIR_TIME']


temp = pd.read_csv('flights.csv', names=headers, index_col=False)

# temp['DEP_TIME'] = temp['DEP_TIME'].astype(str)
# temp['DEP_TIME'] = temp['DEP_TIME'].str.slice(0, -2)
# temp['DEP_TIME'] = temp['DEP_TIME'].str.replace('n', '')

temp['DEP_DELAY_NEW'] = temp['DEP_DELAY_NEW'].astype(str)
temp['DEP_DELAY_NEW'] = temp['DEP_DELAY_NEW'].str.slice(0, -2)
temp['DEP_DELAY_NEW'] = temp['DEP_DELAY_NEW'].str.replace('n', '')

# temp['ARR_TIME'] = temp['ARR_TIME'].astype(str)
# temp['ARR_TIME'] = temp['ARR_TIME'].str.slice(0, -2)
# temp['ARR_TIME'] = temp['ARR_TIME'].str.replace('n', '')

temp['ARR_DELAY_NEW'] = temp['ARR_DELAY_NEW'].astype(str)
temp['ARR_DELAY_NEW'] = temp['ARR_DELAY_NEW'].str.slice(0, -2)
temp['ARR_DELAY_NEW'] = temp['ARR_DELAY_NEW'].str.replace('n', '')

# temp['CANCELLED'] = temp['CANCELLED'].astype(str)
# temp['CANCELLED'] = temp['CANCELLED'].str.slice(0, -2)
# temp['CANCELLED'] = temp['CANCELLED'].str.replace('n', '')

temp['AIR_TIME'] = temp['AIR_TIME'].astype(str)
temp['AIR_TIME'] = temp['AIR_TIME'].str.slice(0, -2)
temp['AIR_TIME'] = temp['AIR_TIME'].str.replace('n', '')

# temp['ORIGIN_CITY_NAME'] = temp['ORIGIN_CITY_NAME'].astype(str)
# temp['ORIGIN_CITY_NAME'] = temp['ORIGIN_CITY_NAME'].str.slice(0, -4)

# temp['DEST_CITY_NAME'] = temp['DEST_CITY_NAME'].astype(str)
# temp['DEST_CITY_NAME'] = temp['DEST_CITY_NAME'].str.slice(0, -4)

print(temp)
temp.to_csv('flights.csv', index=False, header=False)
