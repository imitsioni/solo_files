import csv
import matplotlib.pyplot as plt
import numpy as np


# file = 'cart_pose.csv'
# with open(file) as csvfile:
#     readCSV = csv.reader(csvfile, delimiter = ',')
#     x_pos = []
#     y_pos = []
#     z_pos = []
#     for row in readCSV:
#         x_pos.append(float(row[0]))
#         y_pos.append(float(row[1]))
#         z_pos.append(float(row[2]))
#
# time = np.arange(0,len(y_pos));# time = [i for i in range(0, len(y_pos[1::1000]))]
# plt.figure(figsize = (20,20))
#
# plt.plot(time, y_pos)
# plt.show()


file = '/home/igmitsio/Desktop/Experiments_and_dump/tuesday/banana7_forces.csv'
with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter = ',')
    f_x = []
    f_y = []
    f_z = []
    header_seq = []
    for row in readCSV:
        header_seq.append(float(row[1]))
        f_x.append(float(row[4]))
        f_y.append(float(row[5]))
        f_z.append(float(row[6]))

time = np.arange(0,len(f_y));# time = [i for i in range(0, len(f_y[1::1000]))]
plt.figure(num = 0, figsize = (30,30))
plt.plot(header_seq, f_x, label = "F_x")
plt.plot(header_seq, f_y, label = "F_y")
plt.plot(header_seq, f_z, label = "F_z")
 # header_seq, x_pos, header_seq, z_pos)
plt.legend()



file = '/home/igmitsio/Desktop/Experiments_and_dump/tuesday/banana7_traje.csv'
with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter = ',')
    # x_pos = []
    y_pos = []
    header_seq = []
    # header_seq = []
    for row in readCSV:
        header_seq.append(float(row[0]))
        y_pos.append(float(row[1]))

time = np.arange(0,len(f_y));# time = [i for i in range(0, len(f_y[1::1000]))]
plt.figure(num = 1, figsize = (30,30))
plt.plot(header_seq, y_pos, label = "Trajectory_Y")
plt.hold()

# plt.plot(header_seq, f_z, label = "F_z")
# plt.plot(header_seq, f_y, label = "F_y")
 # header_seq, x_pos, header_seq, z_pos)
plt.legend()


file = '/home/igmitsio/Desktop/Experiments_and_dump/tuesday/banana7.csv'
with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter = ',')
    # x_pos = []
    y_pos2 = []
    header_seq = []
    # header_seq = []
    for row in readCSV:
        header_seq.append(float(row[0]))
        y_pos2.append(float(row[2]))

time = np.arange(0,len(f_y));# time = [i for i in range(0, len(f_y[1::1000]))]
plt.figure(num = 2, figsize = (30,30))
plt.plot(header_seq, y_pos2, label = "Executed_Y")
# plt.plot(header_seq, f_z, label = "F_z")
# plt.plot(header_seq, f_y, label = "F_y")
 # header_seq, x_pos, header_seq, z_pos)
plt.legend()



plt.show()
