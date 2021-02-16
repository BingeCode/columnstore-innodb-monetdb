from utility_functions import *

headers = ['YEAR', 'MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK', 'OP_UNIQUE_CARRIER', 'ORIGIN_CITY_NAME',
           'ORIGIN_STATE_ABR', 'DEST_CITY_NAME', 'DEST_STATE_ABR', 'CRS_DEP_TIME', 'DEP_DELAY_NEW',
           'CRS_ARR_TIME', 'ARR_DELAY_NEW', 'CANCELLED', 'CANCELLATION_CODE', 'AIR_TIME', 'DISTANCE']

result = pd.DataFrame()


def printProgressBar(iteration, total, prefix='', suffix='', decimals=1, length=100, fill='█', printEnd="\r"):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
        printEnd    - Optional  : end character (e.g. "\r", "\r\n") (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 *
                                                     (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f'\r{prefix} |{bar}| {percent}% {suffix}', end=printEnd)
    # Print New Line on Complete
    if iteration == total:
        print()


printProgressBar(0, 11, prefix='Progress:', suffix='Complete', length=50)


for i in range(1, 12):
    if i < 10:
        i = "0" + str(i)
    path = f'./Data new/flights_{i}.csv'
    temp = pd.read_csv(path, names=headers, index_col=False, low_memory=False)

    removeState(temp)
    convertFloats(temp)
    normalizeTime(temp)
    fillNaN(temp)

    printProgressBar(int(i), 11, prefix='Progress:',
                     suffix='Complete', length=50)

    temp.to_csv(f'./New cleaned/flights_{i}.csv', index=False, header=False)
