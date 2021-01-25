import pandas as pd


temp = pd.read_csv("Data/flights_02.csv")

print(temp)

temp.to_csv('flights_02.csv', index=False)

# result = pd.DataFrame()

# for i in range(1, 12):
#     if i < 10:
#         i = "0" + str(i)
#     path = f'./Data/flights_{i}.csv'
#     temp = pd.read_csv(path)
#     result = result.append(temp)
#     print("Current size: ", result.size)

# result.to_csv('flights_all.csv', index=False)
