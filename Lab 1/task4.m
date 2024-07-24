% Task 4
mover6 = importrobot('CPMOVER6.urdf');

ik = inverseKinematics('RigidBodyTree', mover6);
weights = [0.25 0.25 0.25 1 1 1];
tform = getTransform(mover6, mover6.homeConfiguration, 'link6', 'base_link');

initialguess = mover6.homeConfiguration;
[configSoln, solnInfo] = ik('link6', tform, weights, initialguess);

% Display solnInfo using homeConfiguration
disp("Home Configuration");
disp(solnInfo);

initialguess = randomConfiguration(mover6);
[configSoln, solnInfo] = ik('link6', tform, weights, initialguess);

% Display solnInfo using randomConfiguration
disp("Random Configuration");
disp(solnInfo);
