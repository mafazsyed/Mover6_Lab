% Task 1
robot = rigidBodyTree;

% Joint 1
body = rigidBody('link1');
jnt1 = rigidBodyJoint('jnt1', 'revolute');
jnt1.HomePosition = pi/4;
tform = trvec2tform([0.25 0.25 0]);
setFixedTransform(jnt1, tform);
body.Joint = jnt1;
addBody(robot, body, 'base');

% Joint 2:  Revolute joint, at default position of 30 degrees at a distance of 1 unit in the X from joint 1
body = rigidBody('link2');
jnt2 = rigidBodyJoint('jnt2', 'revolute');
jnt2.HomePosition = pi/6;
tform = trvec2tform([1 0 0]);
setFixedTransform(jnt2, tform);
body.Joint = jnt2;
addBody(robot, body, 'link1');

% Joint 3: Revolute joint, at a default position of 0 degrees at a distance of 0.6 units in X and -0.1 units 
% in Y from joint 2 with a frame rotation of -90 degrees about Z
body = rigidBody('link3');
jnt3 = rigidBodyJoint('jnt3', 'revolute');
jnt3.HomePosition = 0;
tform = trvec2tform([0.6 -0.1 0]) * eul2tform([0 0 -pi/2]);
setFixedTransform(jnt3, tform);
body.Joint = jnt3;
addBody(robot, body, 'link2');

% Joint 4: Revolute joint, at default position of 45 degrees at a distance of 1 unit in the X direction from joint 3 
body = rigidBody('link4');
jnt4 = rigidBodyJoint('jnt4', 'revolute');
jnt4.HomePosition = pi/4;
tform = trvec2tform([1 0 0]);
setFixedTransform(jnt4, tform);
body.Joint = jnt4;
addBody(robot, body, 'link3');

% End effector: Connect this to joint 4.
body = rigidBody('eef');
tform = trvec2tform([0 0 0]);
setFixedTransform(body.Joint, tform);
addBody(robot, body, 'link4');

% plot the robot
% robot.show

% Task 2
% Task 2a: Determine the transform from the base to the end effector
base_to_ee = getTransform(robot, homeConfiguration(robot), 'link1', 'base') * ...
                getTransform(robot, homeConfiguration(robot), 'link2', 'link1') * ... 
                getTransform(robot, homeConfiguration(robot), 'link3', 'link2') * ...
                getTransform(robot, homeConfiguration(robot), 'link4', 'link3') * ...
                getTransform(robot, homeConfiguration(robot), 'eef', 'link4');

% Task 2b: Determine the transform from the joint1 to the end effector
jnt1_to_ee = getTransform(robot, homeConfiguration(robot), 'link2', 'link1') * ... 
                getTransform(robot, homeConfiguration(robot), 'link3', 'link2') * ...
                getTransform(robot, homeConfiguration(robot), 'link4', 'link3') * ...
                getTransform(robot, homeConfiguration(robot), 'eef', 'link4');

% Task 2c and 2d
base_to_ee = getTransform(robot, homeConfiguration(robot), 'eef', 'base');
jnt1_to_ee = getTransform(robot, homeConfiguration(robot), 'eef', 'link1');
