import pandas as pd


def printProgressBar(iteration, total, prefix='Progress:', suffix='Complete', decimals=1, length=100, fill='█', printEnd="\r"):
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


def removeState(df: pd.DataFrame):
    """
    Removing name of state from city name columns
    """
    columns = ['ORIGIN_CITY_NAME', 'DEST_CITY_NAME']

    for column in columns:
        df[column] = df[column].astype(str)
        df[column] = df[column].str.slice(0, -4)


def convertFloats(df: pd.DataFrame):
    """
    Converting float values to ints
    """
    columns = ['DEP_DELAY_NEW', 'ARR_DELAY_NEW',
               'CANCELLED', 'AIR_TIME', 'DISTANCE']

    for column in columns:
        df[column] = df[column].astype(str)
        df[column] = df[column].str.slice(0, -2)
        df[column] = df[column].str.replace('n', '')


def normalizeTime(df: pd.DataFrame):
    """
    Normalizing time strings to format hh:mm:ss
    """
    columns = ['CRS_DEP_TIME', 'CRS_ARR_TIME']

    for column in columns:
        df[column] = df[column].astype(str)
        df[column] = (pd.to_datetime(df[column], format='%H%M', errors='coerce')
                      .dt.strftime('%H:%M:%S')
                      .fillna('NULL'))


def fillNaN(df: pd.DataFrame):
    """
    Filling NaN values and empty strings with 'NULL'
    """
    df.fillna("NULL", inplace=True)
    df.replace(r'^\s*$', 'NULL', regex=True, inplace=True)
