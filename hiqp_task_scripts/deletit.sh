
#  SCRIPT TO TEST GEOMETRIC PRIMITIVES

rosservice call /yumi/hiqp_joint_velocity_controller/set_primitives \
"primitives:


- name: 'target_frame'
  type: 'frame'
  frame_id: 'yumi_base_link'
  visible: true
  color: [1.0, 0.0, 1.0, 1.0]
  parameters: [0.22, -0.08 , 0.05 , 0.0, 0.0, 0.0]"
