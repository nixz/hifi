//
// Antialiasing.qml
//
//  Created by Sam Gateau on 8/14/2017
//  Copyright 2016 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or https://www.apache.org/licenses/LICENSE-2.0.html
//

import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import stylesUit 1.0
import controlsUit 1.0 as HifiControls
    
import "../configSlider"
import "../../lib/plotperf"

import "../../lib/prop" as Prop

    
Column{
    id: antialiasing

    anchors.left: parent.left
    anchors.right: parent.right 

    Prop.PropScalar {
        label: "MSAA"
        object: Render.getConfig("RenderMainView.PreparePrimaryBufferForward")
        property: "numSamples"
        min: 1
        max: 32
        integral: true
    }

    Prop.PropEnum {
        label: "Deferred AA Method"
        enums: [
            "Off",
            "TAA",
            "FXAA",
                ]

        valueVarSetter: function (mode) { setAAMode(mode) }
        valueVarGetter: function () { return Render.getConfig("RenderMainView.JitterCam").state +
                                             Render.getConfig("RenderMainView.Antialiasing").fxaaOnOff * 2 }

        function setAAMode(mode) {
            console.log("Deferred AA mode is " + mode)
            
            if (mode == 0) {
                Render.getConfig("RenderMainView.JitterCam").state = 0;
                Render.getConfig("RenderMainView.Antialiasing").fxaaOnOff = false;
            } else if (mode == 1) {
                Render.getConfig("RenderMainView.JitterCam").state = 1;
                Render.getConfig("RenderMainView.Antialiasing").fxaaOnOff = false;
            } else {
                Render.getConfig("RenderMainView.JitterCam").state = 0;
                Render.getConfig("RenderMainView.Antialiasing").fxaaOnOff = true;
            }
        }
    }
    Separator {}          
    Prop.PropEnum {
        label: "Jitter"
        object: Render.getConfig("RenderMainView.JitterCam")
        property: "state"

        enums: [
            "Off",
            "On",
            "Paused",
                ]
    }
    Prop.PropScalar {
        label: "Sample Index"
        object: Render.getConfig("RenderMainView.JitterCam")
        property: "index"
      //  min: -1
      //  max: 32
        readOnly: true
        integral: true
    }
    Row {
        spacing: 10

        HifiControls.Button {
            text: "<"
            onClicked: { Render.getConfig("RenderMainView.JitterCam").prev(); }
        } 
        HifiControls.Button {
            text: ">"
            onClicked: { Render.getConfig("RenderMainView.JitterCam").next(); }
        }
    }
    Separator {}
    Prop.PropBool {
        label: "Constrain color"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "constrainColor"
    }         
    Prop.PropScalar {
        label: "Covariance gamma"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "covarianceGamma"
        max: 1.5
        min: 0.5
    }                       
    Separator {}
    Prop.PropBool {
        label: "Feedback history color"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "feedbackColor"
    }           
    Prop.PropScalar {
        label: "Source blend"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "blend"
        max: 1.0
        min: 0.0
    }
    Prop.PropScalar {
        label: "Post sharpen"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "sharpen"
        max: 1.0
        min: 0.0
    }
    Separator {}
    Prop.PropBool {
        label: "Debug"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "debug"
    }   
    Prop.PropBool {
        label: "Show Debug Cursor"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "showCursorPixel"
    }                         
    Prop.PropScalar {
        label: "Debug Region <"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "debugX"
        max: 1.0
        min: 0.0
    }
    Prop.PropBool {
        label: "Closest Fragment"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "showClosestFragment"
    }
    Prop.PropScalar {
        label: "Debug Velocity Threshold [pix]"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "debugShowVelocityThreshold"
        max: 50
        min: 0.0
    }
    Prop.PropScalar {
        label: "Debug Orb Zoom"
        object: Render.getConfig("RenderMainView.Antialiasing")
        property: "debugOrbZoom"
        max: 32.0
        min: 1.0
    } 
}

