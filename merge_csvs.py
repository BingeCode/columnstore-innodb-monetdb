from utility_functions import *

result = pd.DataFrame()

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

result.to_csv('flights.csv', index=False, header=False)
printProgressBar(end_month + 1, end_month + 1)
