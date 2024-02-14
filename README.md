# Rigid Body Dynamics

## Aim
This repository is created to be able to simulate motion of `a rigid body` under forces and moments.

## Frame Conventions
Two main frames are used in this simulation both of which are right handed. Flat Earth assumption is made.
* $\ E$ : `Earth Frame` Coincident with North-East-Down (NED) Frame. Assumed to be inertial.
* $\ B$ : `Body Frame`

## Orientation Formalism
Rotated Frame Based ZYX (Yaw, Pitch, Roll) Euler Angle sequence is used to represent the orientation.

## States
* $\ X$ : `Position` with respect to Earth Frame
    * North
    * East
    * Down
* $\ \Phi$ : `Orientation` of Body Frame with respect to Earth Frame
    * Roll
    * Pitch
    * Yaw
* $\ V$ : `Cartesian Velocity` with respect to Body Frame
    * Surge
    * Sway
    * Heave
* $\ \Omega$ : `Angular Velocity` with respect to Body Frame
    * Roll rate
    * Pitch rate
    * Yaw rate

## Inputs
At any time step, simulation has two vectorial inputs.
* $\ F$ : `Force vector` represented in Body Frame
* $\ M$ : `Moment vector` represented in Body Frame, about the body's `mass center`.

## Rigid Body Specifications
A rigid body has two specifications in the sense of its motion under defined forces. Those are its inertial characteristics.
* $\ m$ : `Mass` of the object
* $\ J$ : `Inertia Tensor` of the object about its `mass center` represented in `Body Frame`.

## Equations of Motion
Equations are based on Newton-Euler `Equations`. They are written for the point located on the `mass center`.
* $\ \dot{V} = F / m - \Omega \times V $
* $\ \dot{\Omega} = J^{-1} (M - \Omega \times J \Omega) $

Having found velocities represented on the body frame, location on the Earth frame and orientation of the body with respect to Earth frame can be found with the following equations.
* $\ \dot{X} = C_{B2E} \dot{V}$
* $\ \dot{\Phi} = C_{\Omega 2 \dot{\Phi}} \Omega $

## Plots
Although the mass and inertia matrices are completely free from all constraints, when plotting a hard-coded `rectangular prism` is selected. It is fairly easy to create a different shape but this option not available at the moment. 

In the figure below, positive z-axis is from green to red plane.

![Plot Example](/pics/example_pose.jpg "Plot Example")

## Numerical Integration
Repository uses either of the following methods for `numerical integration`:
* 4th Order Explicit Runge-Kutta
* 1st Order Explicit Euler's 

For general stability, 4th Order Explicit Runge-Kutta method is advised to be used.

## Future Works
* Use `quaternions` in equations of motions and report Euler Angles if necessary
* Add different shapes for plotting
