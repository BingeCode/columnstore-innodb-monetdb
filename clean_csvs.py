from utility_functions import *

result = pd.DataFrame()

start_month = 1
end_month = 12

printProgressBar(start_month - 1, end_month * 7)


for i in range(1, end_month + 1):

    if i < 10:
        i = "0" + str(i)
    path = f'./Data/flights_{i}.csv'
    temp = pd.read_csv(path, index_col=False, low_memory=False)
    printProgressBar(int(i) * 7 - 6, end_month * 7)

    temp = temp.iloc[:, :-1]
    printProgressBar(int(i) * 7 - 5, end_month * 7)

    removeState(temp)
    printProgressBar(int(i) * 7 - 4, end_month * 7)

    convertFloats(temp)
    printProgressBar(int(i) * 7 - 3, end_month * 7)

    normalizeTime(temp)
    printProgressBar(int(i) * 7 - 2, end_month * 7)

    fillNaN(temp)
    printProgressBar(int(i) * 7 - 1, end_month * 7)

    temp.to_csv(f'./New/flights_{i}.csv', index=False, header=False)
    printProgressBar(int(i) * 7, end_month * 7)
