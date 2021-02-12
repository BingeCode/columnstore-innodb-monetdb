import pandas as pd

headers = ['YEAR', 'MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK', 'ORIGIN_CITY_NAME', 'ORIGIN_STATE_ABR', 'DEST_CITY_NAME',
           'DEST_STATE_ABR', 'DEP_TIME', 'DEP_DELAY_NEW', 'ARR_TIME', 'ARR_DELAY_NEW', 'CANCELLED', 'AIR_TIME']

result = pd.DataFrame()

for i in range(1, 12):
    if i < 10:
        i = "0" + str(i)

    path = f'./New/flights_{i}.csv'
    temp = pd.read_csv(path, names=headers, index_col=False)
    result = result.append(temp, ignore_index=True)
    print("Current size: ", result.size)

result.to_csv('flights.csv', index=False, header=False)
