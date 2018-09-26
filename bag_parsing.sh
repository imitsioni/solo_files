#!/bin/bash

# assuming 1st argument is folder that contains the bag,
# 2nd one folder-to-be-created name and
# 3rd one the rosbag to parse

mkdir -p $1/$2
cd $1 # get in the bag containing folder
touch $2/forces.txt $2/positions.txt $2/velocities.txt $2/trajectory.txt
echo I created $1/$2!

rostopic echo -b $3 -p /admittance_controller/cartesian_pose_R > $2/positions.txt
rostopic echo -b $3 -p /admittance_controller/wrench_world_r > $2/forces.txt
rostopic echo -b $3 -p /admittance_controller/commanded_velocities > $2/velocities.txt
rostopic echo -b $3 -p /trajectory_points > $2/trajectory.txt
