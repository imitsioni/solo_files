rosservice call /yumi/hiqp_joint_velocity_controller/set_primitives \
"primitives:

 - name: ee_right_frame
   type: frame 
   frame_id: gripper_r_base
   visible: true
   color: [0.0, 0.5, 0.0, 1.0]
   parameters: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
 - name: ee_left_frame
   type: frame 
   frame_id: gripper_l_base
   visible: true
   color: [0.0, 0.5, 0.0, 1.0]
   parameters: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
   
 - name: 'target_frame'
   type: 'frame'
   frame_id: 'yumi_body'
   visible: false
   color: [3.0, 1.0, 1.0, 1.0]
   parameters: [0.42, -0.08 , 0.05,  0.0, 1.57, 1.57]

 - name: 'target_frame2'
   type: 'frame'
   frame_id: 'yumi_body'
   visible: false
   color: [3.0, 1.0, 1.0, 1.0]
   parameters: [0.5, 0.5 , 0.5,  0.0, 1.57, 1.57]
   
   
   "
   
rosservice call /yumi/hiqp_joint_velocity_controller/set_tasks \
   "tasks:


      - name: 'ee_right_frame_tracking'
        priority: 2
        visible: true
        active: true
        monitored: true
        def_params: ['TDefTracking', 'frame', 'frame', 'target_frame = ee_right_frame', '0.05', '0.5'] #target_frame is given via service calls offered by the skill_manager
        dyn_params: ['TDynPD', '10.0', '10.0', '10.0', '3.0', '3.0', '3.0', '7.0', '7.0','7.0', '8.0', '8.0', '8.0']
        
        
      

      - name: 'ee_left_frame_tracking'
        priority: 2
        visible: true
        active: true
        monitored: true
        def_params: ['TDefTracking', 'frame', 'frame', 'target_frame2 = ee_left_frame', '0.05', '0.5'] 
        dyn_params: ['TDynPD', '10.0', '10.0', '10.0', '3.0', '3.0', '3.0', '7.0', '7.0','7.0', '8.0', '8.0', '8.0']
        
        
      - name: 'neutral_pose'
        priority: 3
        visible: true
        active: true
        monitored: true
        def_params: ['TDefFullPose', '-0.4478764533996582', '-1.2682621479034424', '1.9585838317871094', '0.4285459518432617', '0.985352098941803', '-0.024183640256524086', '-0.5602127313613892', '0.5301980376243591', '-1.8081225156784058', '-1.3030146360397339', '0.3174477219581604', '-2.0786147117614746', '0.8679736256599426', '3.358731985092163']
        dyn_params: ['TDynPD', '1.0', '2.0'] "



