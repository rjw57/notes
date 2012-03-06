Estimating the state of the AR.Drone
====================================

.. default-role:: math

This note talks about some possible strategies for updating an assumed state of an AR.Drone given noisy sensor inputs.
It is not intended as a full discussion of the problem but it is intended as a good jumping off point.

I am going to assume that the full state of the drone can be represented by the pair `(\omega, \theta)` where `\omega`
represents the physical configuration of the drone:

.. math::

    \omega = [ x, y, z, \alpha, \beta, \gamma ],

where `x`, `y` and `z` are the absolute position of the drone relative to some origin and `\alpha`, `\beta` and `\gamma`
are the absolute pitch, roll and yaw. The `\theta` vector represents our current estimates of the correction parameters
necessary to convert sensor measurements into an estimate of `\omega`. We shall fill in this vector as we proceed.

I'll assume that a) the floor is flat and b) the floor is the `z = 0` plane and so `z` is the vertical distance from the
drone to the floor.

I'm also assuming that the real-world time between `t-1` and `t` is one second. In general this wont be the case and so
an appropriate `\Delta t` should be inserted into these equations where necessary.

Estimating `\omega` from the drone
----------------------------------

The drone provides estimates of `x'_t = dx / dt` and `y'_t = dy / dt` in metres-per-second. It also provides a direct
estimate of height, `h_t`. Given some estimate of state at time `t-1`, `\hat{\omega}_{t-1}`, it is clear that our
estimate of position at time `t` given the drone's sensors is:

.. math::

    \hat{x}^{(d)}_t = \hat{x}_{t-1} + x'_t, \quad
    \hat{y}^{(d)}_t = \hat{y}_{t-1} + y'_t, \quad
    \hat{z}^{(d)}_t = h_t.

The drone provides direct estimates of yaw, pitch and roll. Since pitch and roll are measured using an accelerometer we
shall assume that the drone is accelerating slowly w.r.t. gravity and hence:

.. math::

    \hat{\alpha}^{(d)}_t = \alpha_t, \quad
    \hat{\beta}^{(d)}_t = \beta_t.

We assume that the yaw is subject to some linear drift, `\Delta\gamma` over time and so:

.. math::

    \hat{\gamma}^{(d)}_t = \hat{\gamma}_{t-1} + (\gamma_t - \gamma_{t-1}) - \hat{\Delta\gamma}

where `\hat{\Delta\gamma}` is our current estimate of the linear drift. There are many ways of estimating this. A very
simple one is to keep track of the expected value of `\hat{\gamma}_{t} - \hat{\gamma}_{t-1}` due to the commands
we're sending the drone (e.g. we expect `\hat{\gamma}_{t-1} = \hat{\gamma}_t` if we are sending a zero-yaw command) and
update `\hat{\Delta\gamma}` from the measured `\gamma_t - \gamma_{t-1}`. Ideally this should be smoothed over time with
some sort of moving average process. This is left as an exercise for the reader(!)

The value we need to add to the `\theta` vector is therefore `\hat{\Delta\gamma}`.

Estimating `\omega` from the video
----------------------------------

Let `f_x` be the horizontal field of view in degrees and `f_y` be the vertical field of view in degrees. Therefore, if
the drone is not moving, a linear pixel offset between the frame at time `t-1` and `t` of `(\Delta x, \Delta y)`
directly leads to image-based estimators for the pitch and roll:

.. math::

    \hat{\alpha}^{(i)}_t = \hat{\alpha}_{t-1} + f_y \Delta y, \quad
    \hat{\beta}^{(i)}_t = \hat{\beta}_{t-1} + f_x \Delta x.

The roll may also be directly estimated from the image. If `\phi` is the estimated rotational change of the image from
`t-1` to `t`, then:

.. math::

    \hat{\gamma}^{(i)}_t = \hat{\gamma}_{t-1} + \phi.

In a real system, one would need to account for the horizontal and linear velocities and subtract their contributions
from `(\Delta x, \Delta y)`. This is also left as an exercise(!)

The video stream does not provide a direct way to estimate position but of course if there are markers with known
locations in the scene, some information may be gleaned.

Estimating `\omega` from the dynamics of the drone
--------------------------------------------------

Finally, given the configuration of the drone we have commanded, we can estimate what we *expect* `\omega_t` to be given
only `\hat{\omega}_{t-1}`. For example, If we are commanding a delta-yaw of `\Delta \gamma = 10` degrees-per-second then
we may estimate, using our dynamic model of the drone, that

.. math::

    \hat{\gamma}^{(m)} = \hat{\gamma}_{t-1} + \Delta \gamma

Other models for the remaining elements of `\hat{\omega}^{(m)}` may be constructed.

Fusing the sensor estimates
---------------------------

Suppose we have a set of values, `k_i`, `k_d` and `k_m`, which reflect our relative beliefs in the accuracy of the
image-based, drone-reported and model-based estimate of our current state. The full estimator for our state is therefore

.. math::

    \hat{\omega}_t = \frac{k_d \hat{\omega}^{(d)}_t + k_i \hat{\omega}^{(i)}_t + k_m \hat{\omega}^{(m)}_t}
    {k_d + k_i + k_m}.

The values of `k_i`, `k_d` and `k_m` may be set empirically or one might set them via a Kalman filter. This too is left
as an exercise.

