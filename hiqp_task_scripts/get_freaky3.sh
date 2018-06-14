# # =============================================================================
#                 1. ALIGN frames to get to initial position
#                 2. Point to point Tracking to get to iniatial position
#                 3. Point to plane projection to chop
# =============================================================================


# # Modelling the chopping motion through geometric primitives and Stacks of tasks
# # Description (short) :
#
# Initial pose :          Align the EE frame with the frame that corresponds to the
# Switch controllers:     Activate admittance controller
# Chop once:              Get the EE to the table's surface



# Comments: It seems that by removing the "full pose" task, task1 and 2 are achieved
#           much more strictly. Unfortunately, that leaves the elbow in weird configurations
#           When more of the movement is specified, do try to remove it and see what happens


# ========== init =========
 source cleanup.sh


rosservice call /yumi/hiqp_joint_velocity_controller/set_primitives \
"primitives:

- name: 'ee_frame'
  type: 'frame'
  frame_id: 'gripper_r_base'
  visible: true
  color: [1.0, 0.0, 0.0, 1.0]
  parameters: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

- name: 'init_frame'
  type: 'frame'
  frame_id: 'yumi_body'
  visible: true
  color: [1.0, 0.0, 1.0, 1.0]
  parameters: [0.22, -0.08 , 0.1 , 0.0, 1.57, 1.57]

- name: 'ee_point'
  type: 'point'
  frame_id: 'gripper_r_base'
  visible: false
  color: [3.0, 1.0, 1.0, 1.0]
  parameters: [0.0, 0.0 , 0.0]

- name: 'target_point'
  type: 'point'
  frame_id: 'yumi_body'
  visible: false
  color: [3.0, 1.0, 1.0, 1.0]
  parameters: [0.22, -0.08 , 1.0]


- name: 'table_plane'
  type: 'plane'
  frame_id: 'yumi_body'
  visible: true
  color: [1.0, 0.0, 1.0, 0.6]
  parameters: [0.0, 0.0, 1.0, -0.1]

  "



  rosservice call /yumi/hiqp_joint_velocity_controller/set_tasks \
  "tasks:


  - name: 'task1'
    priority: 2
    visible: 1
    active: 1
    monitored: 1
    def_params: ['TDefTracking', 'frame', 'frame', 'init_frame = ee_frame', '0.05', '0.5']
    dyn_params: ['TDynPD', '30.0', '30.0', '30.0', '3.0', '3.0', '3.0', '12.0', '12.0', '12.0', '4.0', '4.0', '4.0']

  - name: 'task2'
    priority: 2
    visible: 1
    active: 1
    monitored: 1
    def_params: ['TDefTracking', 'point', 'point', 'ee_point = target_point', '0.04']
    dyn_params: ['TDynPD', '4.0', '1']

  - name: 'full_pose'
    priority: 3
    visible: 1
    active: 1
    monitored: 1
    def_params: ['TDefFullPose']
    dyn_params: ['TDynPD', '1.0', '1.0']

  "




    sleep 15
    # ==================== Phase 2  ========================
    rosservice call /yumi/hiqp_joint_velocity_controller/remove_tasks "names:
    - 'task2'"


    rosservice call /yumi/hiqp_joint_velocity_controller/set_tasks \
    "tasks:


    - name: 'task3'
      priority: 2
      visible: 1
      active: 1
      monitored: 1
      def_params: ['TDefGeomProj', 'point', 'plane', 'ee_point = table_plane']
      dyn_params: ['TDynPD', '10.0', '6.0']"



# ==============================================================================
