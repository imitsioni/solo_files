#!/usr/bin/env bash

# get the live connection going
echo "roslaunch pepper_dcm_bringup pepper_bringup.launch robot_ip:=192.168.1.43 network_interface:=enp7s0"
roslaunch pepper_dcm_bringup pepper_bringup.launch robot_ip:=192.168.1.43 network_interface:=enp7s0
# launch the drivers
echo "roslaunch naoqi_driver naoqi_driver.launch nao_ip:=192.168.1.43 network_interface:=enp7s0"
roslaunch naoqi_driver naoqi_driver.launch nao_ip:=192.168.1.43 network_interface:=enp7s0
# launching moveit
echo MoveIT will be launched by default
if [ $1 = false ];
then
  echo "MoveIT not launching"
else
  roslaunch pepper_moveit_config moveit_planner.launch
  echo "LAUNCHING"
fi
