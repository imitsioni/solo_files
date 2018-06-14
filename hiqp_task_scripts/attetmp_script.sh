# # Basically an attempt to implement what we presented.
# # Assuming the joint limit avoidance has been already called we will break the movement down to:
# #               *** Initial decomp into primitives
#
# Primitives : 1) the ee point 2) the knife axis (black)
# 3) the vertical gripper axis (green) 4) the object axis (orange)  5) the object grasp_plane
# Tasks: 1)
rosservice call /yumi/hiqp_joint_velocity_controller/set_primitives \
"primitives:
- name: 'ee_point'
  type: 'point'
  frame_id: 'gripper_r_base'
  visible: true
  color: [3.0, 1.0, 1.0, 1.0]
  parameters: [0.0, 0.0 , 0.1]

- name: 'knife_axis'
  type: 'line'
  frame_id: 'gripper_r_base'
  visible: true
  color: [0.0, 0.0, 0.0, 1.0]
  parameters: [0, 0, 1, 0, 0, 0.1]


- name: 'object_axis'
  type: 'line'
  frame_id: 'yumi_body'
  visible: true
  color: [4.0, 1.0, 0.0, 1.0]
  parameters: [0, 1.0 , 0, 0.35 , 0, 0.1]

- name: 'target_plane'
  type: 'point'
  frame_id: 'yumi_body'
  visible: false
  color: [0.0, 1.0, 0.0, 0.6]
  parameters: [1.0, 0.0, 0.0]

- name: 'cutting_line'
  type: 'line'
  frame_id: 'yumi_body'
  visible: true
  color: [0.0, 1.0, 0.0, 1.0]
  parameters: [0, 0, 1.0, 0.35, 0, 0]

"



rosservice call /yumi/hiqp_joint_velocity_controller/set_tasks \
"tasks:
  - name: 'task1'
    priority: 2
    visible: 1
    active: 1
    monitored: 1
    def_params: ['TDefTracking', 'point', 'line', 'ee_point = cutting_line', '0.05', '0.5']
    dyn_params: ['TDynPD', '30.0', '30.0', '30.0', '3.0', '3.0', '3.0', '12.0', '12.0', '12.0', '4.0', '4.0', '4.0']

"

  # - name: 'target_plane'
  #   type: 'plane'
  #   frame_id: 'yumi_body'
  #   visible: false
  #   color: [0.0, 1.0, 0.0, 0.6]
  #   parameters: [0.0, 0.0, 1.0, 0.1]


  # rosservice call /yumi/hiqp_joint_velocity_controller/set_tasks \
  # "tasks:
  # - name: 'task1'
  #   priority: 2
  #   visible: 1
  #   active: 1
  #   monitored: 1
  #   def_params: ['TDefGeomAlign', 'line', 'line', 'knife_axis = object_axis']
  #   dyn_params: ['TDynPD', '1.8', '4.0']
  #
  #
  #
  # - name: 'elbow_ffs'
  #   priority: 3
  #   visible: 1
  #   active: 1
  #   monitored: 1
  #   def_params: ['TDefJntConfig', 'yumi_link_4_r', '-0.1']
  #   dyn_params: ['TDynPD', '1.0', '2.0']
  #
  #   "



    # The plugin failed to load for some reason. Error: According to the loaded plugin descriptions the class hiqp::tasks::TDynMinimalJerk with base class type hiqp::TaskDynamics does not exist. Declared types are  hiqp::tasks::TDynPDController
