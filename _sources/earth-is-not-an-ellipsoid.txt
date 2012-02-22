The Earth is *not* an ellipsoid
===============================

.. centered:: FIXME: this is wrong. We end up with an extra term which should not be there.

.. figure:: earth-is-not-an-ellipsoid/ellipse-geometry.png
    :align: center
    :alt: A figure showing the geometry of a slice through the Earth.

It is a reasonable assumption that the Earth is symmetric around its rotational axis. We can therefore just consider a
2D 'slice' through the earth which goes through its centre of mass. The figure above shows the geometry of that slice
through the Earth. The centre of mass of the Earth is at :math:`O` and a point on the surface is at :math:`(x, y)`. The
y-axis is parallel to the line segment :math:`OB` which is also the rotational axis. The line segment :math:`OA` is
perpendicular to :math:`OB` and is parallel to the x-axis.

On the right of the figure we have zoomed in on the point and labelled some unit vectors defining a co-ordinate system
on the surface. The unit vectors :math:`\hat{e}_x` and :math:`\hat{e}_y` point, respectively, along the x- and y-axes.
The unit vector :math:`\hat{e}_N` points along the surface of the Earth in a northerly direction, i.e. in the direction
one must walk to reach :math:`B`.

Assuming the Earth is an ellipsoid
----------------------------------

Firstly, let's proceed by assuming that the Earth *is* an ellipsoid. If so, our slice is an ellipse and we can label the
major and minor radii :math:`a` and :math:`b`. Pythagoras tells us that

.. math:: \frac{x^2}{a^2} + \frac{y^2}{b^2} = 1.

If we differentiate with respect to :math:`x` we get

.. math::

    \frac{2x}{a^2} + \frac{2y}{b^2} \frac{dy}{dx} = 0
    \qquad \Rightarrow \qquad
    \frac{dy}{dx} = - \frac{b^2}{a^2} \frac{x}{y}.

If we let :math:`\hat{e}_N = n_x \hat{e}_x + n_y \hat{e}_y` then it is clear that, at :math:`P`,

.. math::
    :label: ellipse

    \frac{dy}{dx} = \frac{n_y}{n_x}
    \qquad \Rightarrow \qquad
    \frac{n_y}{n_x} = - \frac{b^2}{a^2} \frac{x}{y}.

This is the relation that must be true for the Earth to be an ellipsoid: at all points on the surface :math:`n_y / n_x`
must be proportional to :math:`x / y`. In the next section we'll see if that is true when we consider the physical
equations governing the shape of the Earth.

The physics of the Earth's surface
----------------------------------

Why does the Earth bulge in the middle? The traditional answer is that the centrifugal force 'throws' the surface out
more at the equator than at the poles. This is almost true. In fact it is better to think as the Earth's surface as a
liquid which 'slips' over the globe until it finds an equilibrium point. Since we're assuming the Earth is symmetric
around its axis of rotation, this equilibrium point is only North-South. A point mass on the surface of the Earth will
have the North-South centrifugal force exactly cancelled by the North-South force due to gravity. This must be true
otherwise a ball on the ground would roll Northward or Southward.

Let's consider a point-mass at :math:`P` with mass :math:`m`. The centrifugal force will be directed along the
:math:`\hat{e}_x` direction (i.e. away from the axis of rotation). If the Earth has angular velocity :math:`\omega` then
elementary mechanics tells us that the centrifugal force is

.. math:: f_c = \frac{m x^2 \omega^2}{r} \hat{e}_x.

The force due to gravity is also simple to write down. It acts to pull the mass towards :math:`O` backwards along the
radial direction :math:`\hat{e}_r`. If :math:`\theta` is the angle :math:`OP` makes to :math:`OA` then some elementary
geometry tells us that

.. math:: \hat{e}_r = \hat{e}_x \cos \theta + \hat{e}_y \sin \theta = \frac{x}{r} \hat{e}_x + \frac{y}{r} \hat{e}_y

and so the force due to gravity is

.. math::

    f_g
    = - \frac{G m_e m}{r^2} \hat{e}_r
    = - \frac{G m_e m}{r^2} \left[ \frac{x}{r} \hat{e}_x + \frac{y}{r} \hat{e}_y \right]

where :math:`m_e` is the mass of the Earth.

Calculating the shape of the Earth
----------------------------------

Our physical condition is that the North-South gravity and centrifugal forces cancel and so

.. math::

    f_c \cdot \hat{e}_N + f_g \cdot \hat{e}_N = 0
    \qquad \Rightarrow \qquad
    \frac{m x^2 \omega^2}{r} \hat{e}_x \cdot \hat{e}_N -
    \frac{G m_e m}{r^2} \left[ \frac{x}{r} \hat{e}_x \cdot \hat{e}_N  + \frac{y}{r} \hat{e}_y \cdot \hat{e}_N \right]
    = 0.

We can immediately simplify this equation by eliminating :math:`m` and multiplying by :math:`r` to get

.. math:: 
    :label: phys-cond

    x^2 \omega^2 \ \hat{e}_x \cdot \hat{e}_N -
    G m_e \left[ \frac{x}{r^2} \hat{e}_x \cdot \hat{e}_N + \frac{y}{r^2} \hat{e}_y \cdot \hat{e}_N \right]
    = 0.

Since :math:`r^{-2} = (x^2 + y^2)^{-1}`, via the chain rule, it must be that

.. math:: \frac{d}{dx} r^{-2} = 2x \cdot -(x^2 + y^2)^{-2} = - 2 \frac{x}{r^4}

and so, via the product rule,

.. math::

    \frac{d}{dx} \frac{x}{r^2} = \frac{1}{r^2} - 2 \frac{x^2}{r^4},
    \qquad
    \frac{d}{dx} \frac{y}{r^2} = - 2 \frac{xy}{r^4}.

We can now differentiate both sides of equation :eq:`phys-cond` to get

.. math::

    2 x \omega^2 \hat{e}_x \cdot \hat{e}_N +
    G m_e \left[ 2 \frac{x^2}{r^4} - \frac{1}{r^2} \right] \hat{e}_x \cdot \hat{e}_N  +
    G m_e \left[ 2 \frac{xy}{r^4} \right] \hat{e}_x \cdot \hat{e}_N  = 0.

Again, we can simplify by eliminating a factor of :math:`2x / r^2`, collecting like terms and remembering our definition
of :math:`n_x = \hat{e}_x \cdot \hat{e}_N` and :math:`n_y = \hat{e}_x \cdot \hat{e}_N`:

.. math::

    G m_e \left[ \frac{y}{r^2} \right] n_y =
    \left( G m_e \left[ \frac{1}{2x} - \frac{x}{r^2} \right] - r^2 \omega^2 \right) n_x.

If we rearrange to get an expression for :math:`n_y / n_x` we get

.. math::

    \frac{n_y}{n_x} =
    - \frac{x}{y}
    + \frac{r^2}{2xy}
    - \frac{r^4 \omega^2}{G m_e} \frac{1}{y}.

Which most certainly doesn't match equation :eq:`ellipse` which holds for an elliptical slice. In fact this differential
equation has no analytic solution.

Conclusions
-----------

We've shown that the shape of a slice through the Earth containing the axis of rotation is not in any way elliptical.
