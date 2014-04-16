//
//  crazylegs.js
//  examples
//
//  Created by Andrzej Kapolka on 3/6/14.
//  Copyright 2014 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

var FREQUENCY = 5.0;

var AMPLITUDE = 45.0;

var cumulativeTime = 0.0;

print("# Joint list start");
var jointList = MyAvatar.getJointNames(); 
for (var i = 0; i < jointList.length; i++) {
    print("jointIndex = " + jointList[i] + " = " + i);
}
print("# Joint list end"); 

var foo = AnimationCache.getAnimation("http://www.fungibleinsight.com/faces/hip_hop_dancing_2.fbx");

Script.update.connect(function(deltaTime) {
    cumulativeTime += deltaTime;
    MyAvatar.setJointData("joint_R_hip", Quat.fromPitchYawRollDegrees(0.0, 0.0, AMPLITUDE * Math.sin(cumulativeTime * FREQUENCY)));
    MyAvatar.setJointData("joint_L_hip", Quat.fromPitchYawRollDegrees(0.0, 0.0, -AMPLITUDE * Math.sin(cumulativeTime * FREQUENCY)));
    MyAvatar.setJointData("joint_R_knee", Quat.fromPitchYawRollDegrees(0.0, 0.0,
        AMPLITUDE * (1.0 + Math.sin(cumulativeTime * FREQUENCY))));
    MyAvatar.setJointData("joint_L_knee", Quat.fromPitchYawRollDegrees(0.0, 0.0,
        AMPLITUDE * (1.0 - Math.sin(cumulativeTime * FREQUENCY))));
        
    if (foo.jointNames.length > 0) {
        print(foo.jointNames);
        print(foo.frames.length);
        if (foo.frames.length > 0) {
            print(foo.frames[0].rotations.length);
            if (foo.frames[0].rotations.length > 0) {
                var rot = foo.frames[0].rotations[0];
                print(rot.x + " " + rot.y + " " + rot.z + " " + rot.w);
            }
        }
    }
});

Script.scriptEnding.connect(function() {
    MyAvatar.clearJointData("joint_R_hip");
    MyAvatar.clearJointData("joint_L_hip");
    MyAvatar.clearJointData("joint_R_knee");
    MyAvatar.clearJointData("joint_L_knee");
});
