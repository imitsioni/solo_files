import matplotlib.pyplot as plt
import numpy as np
from sklearn import preprocessing


path = '/home/igmitsio/Envs/bananaenv/scripts/';
folder = '25_sept/shit/banana'


filename = path + folder + '/forces.txt';

time, seq, f_x, f_y, f_z, t_x, t_y, t_z = np.loadtxt(filename, usecols = (0, 1, 4, 5, 6, 7, 8,9), skiprows = 1, delimiter = ',', unpack = True)
print(seq.shape, f_x.shape)

f_x = f_x.reshape(-1,1)
f_y = f_y.reshape(-1,1)
f_z = f_z.reshape(-1,1)

# force_scaler = preprocessing.MinMaxScaler()
# f_x = force_scaler.fit_transform(f_x)
# f_y = force_scaler.fit_transform(f_y)
# f_z = force_scaler.fit_transform(f_z)

filename = path + folder + '/positions.txt'
time_2, seq_2, p_x, p_y, p_z = np.loadtxt(filename, usecols = (0, 1, 4, 5, 6), skiprows = 1, delimiter = ',', unpack = True)

p_x = p_x.reshape(-1,1)
p_y = p_y.reshape(-1,1)
p_z = p_z.reshape(-1,1)

position_scaler = preprocessing.MinMaxScaler(feature_range = (-1,0))
p_x = position_scaler.fit_transform(p_x)
p_y = position_scaler.fit_transform(p_y)
p_z = position_scaler.fit_transform(p_z)

# filename = path + folder + '/trajectory.txt'
# time_3, seq_3, traj_y = np.loadtxt(filename, usecols = (0, 1, 5), skiprows = 1, delimiter = ',', unpack = True)
# time_3, traj_y = np.loadtxt(filename, usecols = (0, 1), skiprows = 1, delimiter = ',', unpack = True)


# traj_y = traj_y.reshape(-1,1)
# trajectory_scaler = preprocessing.MinMaxScaler()
# traj_y = trajectory_scaler.fit_transform(traj_y)



force_sampling = 100;
plt.figure(0)
plt.plot(seq[::force_sampling], f_x[::force_sampling], label = "F_x", color = "y")
plt.plot(seq[::force_sampling], f_y[::force_sampling], label = "F_y", color = "c")
plt.plot(seq[::force_sampling], f_z[::force_sampling], label = "F_z", color = "m")
# plt.plot(seq_2, p_x, label = "P_x")
plt.plot(seq_2, p_y, linewidth = 3, label = "P_y")
# plt.plot(time_3, traj_y, linewidth = 3, label = "traj_y")
plt.grid(True)
# plt.plot(seq_2, p_z, label = "P_z")

# plt.plot(timestampsoflongruns, longrunYpoints, 'rx')
# plt.plot(timestampsofLAGrun, lagrunYpoints, 'bo')
# plt.axis([*min,maxOfcompleteRun, 0, 20])
plt.legend()
plt.show()

# plt.figure(1)
# the_time = np.linspace(seq[0], seq[-1], 26000)
# f_xs = np.squeeze(f_x)
# f_ys = np.squeeze(f_y)
# f_zs = np.squeeze(f_z)
# fitted_x = np.polyfit(seq, f_xs, 5)
# fitted_y = np.polyfit(seq, f_ys, 5)
# fitted_z = np.polyfit(seq, f_zs, 50)
#
# px = np.poly1d(fitted_x)
# py = np.poly1d(fitted_y)
# pz = np.poly1d(fitted_z)
#
# plt.plot(the_time, px(the_time), label = "F_x")
# plt.plot(the_time, py(the_time), label = "F_y")
# plt.plot(the_time, pz(the_time), label = "F_z")
# plt.plot(seq_2, p_y, linewidth = 1.5, label = "P_y")

plt.legend()
