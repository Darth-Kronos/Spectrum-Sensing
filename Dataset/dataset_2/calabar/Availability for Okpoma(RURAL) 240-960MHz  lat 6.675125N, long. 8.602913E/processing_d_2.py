import os
import csv
folder = []
time_dir = [i for i in os.listdir(".") if i[4:] == "hrs"]
time_dir.sort()
print(time_dir)
path = "{time}/DataFiles 240-340/Last-Spectrum-Trace.csv"
to_save = []
for time in time_dir:
	temp = []
	with open (path.format(time=time)) as csvfile:
		spec = csv.reader(csvfile,delimiter= ',')
		for row in spec:
			temp.append(row[1])
	to_save.append(temp)
with open('dataset_2.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(to_save)